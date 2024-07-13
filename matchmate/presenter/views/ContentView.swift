//
//  ContentView.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 11/07/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var networkMonitor = NetworkMonitor()

    @Environment(\.managedObjectContext) private var viewContext
    //Fetches data from local Database.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "accepted", ascending: true)],
        animation: .default
    )
    private var matches: FetchedResults<DBMatch>
    @StateObject private var viewModel = ViewModel()
    @Namespace var nameSpace
    @State private var isDataLoaded: Bool = false
    @State private var showNetworkErrorView: Bool = false

    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing:0){
                    Spacer()
                        .frame(height: 100)
                        .background(Color.pink)
                    if isDataLoaded {
                        ScrollView {
                            ForEach(matches) { match in
                                CardView(
                                    isAccepted: match.accepted ?? "" ,
                                    title: match.name?.first ?? "nil",
                                    subtitle: match.location?.city ?? "nil",
                                    imageUrl: match.picture?.large ?? "nil",
                                       onAccept: {
                                           print("Accepted")
                                          action(match: match, isAccepted: "yes")
                                       },
                                       onReject: {
                                           print("Rejected")
                                           action(match: match, isAccepted: "no")
                                       }
                                   )
                            }
                        }
                    }
                }
                appBar(isDataLoaded: $isDataLoaded)
            }
            .background(Color.pink.opacity(0.05))
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear{
            networkMonitor.$isConnected
               .receive(on: RunLoop.main)
               .sink { isConnected in
                   print("Network connection status: \(isConnected)")
                   if !isConnected {
                       showNetworkErrorView = true
                   }else{
                       showNetworkErrorView = false
                   }
               }
               .store(in: &networkMonitor.cancellables)
            viewModel.getMatches()
        }
        .onChange(of: viewModel.listOfMatches) { newMatches in
            withAnimation(.bouncy){
                isDataLoaded = true
            }
            addItem(newMatches: newMatches)
        }
        .sheet(isPresented: $showNetworkErrorView){
            NetworkErrorView(showNetworkErrorView: $showNetworkErrorView)
        }
    }
    //Handles the accept and decline CTA button on cardview
    private func action(match:DBMatch,isAccepted:String){
        let request = DBMatch.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", match.email ?? "")
        do{
            let result = try viewContext.fetch(request)
            if result.isEmpty {
                let newMatch = DBMatch(context: viewContext)
                // Assuming name and picture are relationships and not embedded objects
                let name = DBName(context: viewContext)
                name.first = match.name?.first
                name.last = match.name?.last
                name.title = match.name?.title
                newMatch.name = name
                
                let picture = DBPicture(context: viewContext)
                picture.large = match.picture?.large
                picture.medium = match.picture?.medium
                picture.thumbnail = match.picture?.thumbnail
                newMatch.picture = picture
                
                let location = DBLocation(context:viewContext)
                location.city = match.location?.city
                location.country = match.location?.country
                location.state = match.location?.state
                newMatch.location = location

                // Set other properties of DBMatch
                newMatch.gender = match.gender
                newMatch.email = match.email
                newMatch.phone = match.phone
                newMatch.cell = match.cell
                newMatch.nat = match.nat
                newMatch.timeStamp = Date()
                newMatch.id = UUID()
                newMatch.accepted = isAccepted
            }else{
                guard let existingMatch = result.first else{return}
//                let newMatch = DBMatch(context: viewContext)
                // Assuming name and picture are relationships and not embedded objects
                let name = DBName(context: viewContext)
                name.first = match.name?.first
                name.last = match.name?.last
                name.title = match.name?.title
                existingMatch.name = name
                
                let picture = DBPicture(context: viewContext)
                picture.large = match.picture?.large
                picture.medium = match.picture?.medium
                picture.thumbnail = match.picture?.thumbnail
                existingMatch.picture = picture
                
                let location = DBLocation(context:viewContext)
                location.city = match.location?.city
                location.country = match.location?.country
                location.state = match.location?.state
                existingMatch.location = location

                // Set other properties of DBMatch
                existingMatch.gender = match.gender
                existingMatch.email = match.email
                existingMatch.phone = match.phone
                existingMatch.cell = match.cell
                existingMatch.nat = match.nat
                existingMatch.accepted = isAccepted
            }
        }catch let error{
            print("error from update match->\(error)")
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    //Adds new matches from API to Database
    private func addItem(newMatches: [Match]) {
        print("----------we are in add item now----------")
             newMatches.forEach { match in
                 let newMatch = DBMatch(context: viewContext)
                 // Assuming name and picture are relationships and not embedded objects
                 let name = DBName(context: viewContext)
                 name.first = match.name?.first
                 name.last = match.name?.last
                 name.title = match.name?.title
                 newMatch.name = name
                 
                 let picture = DBPicture(context: viewContext)
                 picture.large = match.picture?.large
                 picture.medium = match.picture?.medium
                 picture.thumbnail = match.picture?.thumbnail
                 newMatch.picture = picture
                 
                 let location = DBLocation(context:viewContext)
                 location.city = match.location?.city
                 location.country = match.location?.country
                 location.state = match.location?.state
                 newMatch.location = location

                 // Set other properties of DBMatch
                 newMatch.gender = match.gender
                 newMatch.email = match.email
                 newMatch.phone = match.phone
                 newMatch.cell = match.cell
                 newMatch.nat = match.nat
                 newMatch.timeStamp = Date()
                 newMatch.id = UUID()
             }

             do {
                 try viewContext.save()
             } catch {
                 let nsError = error as NSError
                 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             }
     }
}
