//
//  ContentView.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
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
//    private var NetworkTimeStamp: FetchedResults<DBNetworkTimeStamp>
    @StateObject private var viewModel = ViewModel()
    @Namespace var nameSpace
    @State private var isDataLoaded: Bool = false
    @State private var showNetworkErrorView: Bool = false
    @State private var showGeneralErrorView: Bool = false
    @State private var errorMessage: String = "Unknown error"
    @State private var page:Int = 1
    @State private var results:Int = 10
    @State var showInstructionsView:Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                if !showGeneralErrorView{
                    VStack(spacing:0){
                        Spacer()
                            .frame(height: 100)
                            .background(Color.pink)
                        if isDataLoaded {
                            ScrollView {
                                LazyVStack{
                                    ForEach(matches) { match in
                                        CardView(
                                            isAccepted: match.accepted ?? "" ,
                                            title: match.name?.first ?? "",
                                            subtitle: match.location?.city ?? "",
                                            imageUrl: match.picture?.large ?? "",
                                            onAccept: {
                                                action(match: match, isAccepted: "yes")
                                            },
                                            onReject: {
                                                action(match: match, isAccepted: "no")
                                            }
                                        ).onAppear{
                                            //                                            This will fetch more matches when reached to the last card.
                                            if match == matches.last {
                                                DispatchQueue.global(qos: .background).async {
                                                    page+=1
                                                    viewModel.getMatches(page: page, results: results)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }else{
                    GeneralErrorView(errorMessage: errorMessage) {
                        DispatchQueue.global(qos: .background).async {
                            viewModel.getMatches(page: page, results: results)
                        }
                    }
                }
                appBar(isDataLoaded: $isDataLoaded)
                if(isDataLoaded && showInstructionsView){
                    InstructionsView {
                        print("we are back from instructionview screen")
                        showInstructionsView = false
                    }
                }
            }
            .background(Color.pink.opacity(0.05))
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear{
           
            
            DispatchQueue.global(qos: .background).async {
                //Below code is for displaying instruction for new user
                if let savedValue = UserDefaults.standard.string(forKey: "isFisrtTimeUser") {
                }else{
                    UserDefaults.standard.set(false, forKey: "isFisrtTimeUser")
                    showInstructionsView = true
                }
                //Below code check for network connection
                networkMonitor.$isConnected
                    .receive(on: RunLoop.main)
                    .sink { isConnected in
                        debugPrint("Network connection status: \(isConnected)")
                        if !isConnected {
                            showNetworkErrorView = true
                        }else{
                            showNetworkErrorView = false
                        }
                    }
                    .store(in: &networkMonitor.cancellables)
               //Below code fetches fresh matches from API.
                    viewModel.getMatches(page: page, results: results)
            }
        }
        .onChange(of: viewModel.listOfMatches) { newMatches in
            withAnimation(.bouncy){
                isDataLoaded = true
            }
            DispatchQueue.global(qos: .background).async {
                addItem(newMatches: newMatches)
            }
        }
        .onChange(of: viewModel.errorFromGetMatches){error in
            debugPrint("ERROR from getmatch API caught--->>>\(error)")
            showGeneralErrorView = true
            errorMessage = error
            withAnimation(.bouncy){
                isDataLoaded = true
            }
        }
        .sheet(isPresented: $showNetworkErrorView, onDismiss: {
            DispatchQueue.global(qos: .background).async {
                saveNetworkTimeStamp()
            }
        }){
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
        newMatches.forEach { match in
            let newMatch = DBMatch(context: viewContext)
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
    //Handles saving and updating of network TimeStamp for offline mode
    private func saveNetworkTimeStamp(){
        let request = DBNetworkTimeStamp.fetchRequest()
        do{
            let result = try viewContext.fetch(request)
            if result.isEmpty {
                let newNetworkTimeStamp = DBNetworkTimeStamp(context: viewContext)
                newNetworkTimeStamp.timeStamp = Date()
            }else{
                guard let existingNetworkTimeStamp = result.first else{return}
                existingNetworkTimeStamp.timeStamp = Date()
            }
        }catch let error {
            print(error)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
