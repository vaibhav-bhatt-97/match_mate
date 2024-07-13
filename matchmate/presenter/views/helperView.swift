//
//  helperView.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 12/07/24.
//

import SwiftUI

struct helperView: View {
    @Namespace var nameSpace
    @State private var isDataLoaded: Bool = false
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Spacer()
                    .frame(height: 100)
                
    //            HStack {
    //                Spacer()
    //                Text("Macth Mate")
    //                    .font(.headline)
    //                    .foregroundColor(.white)
    //                Spacer()
    //            }
    //            .padding()
    //            .background(Color.pink)
    //            .frame(maxWidth: .infinity)
    //            Spacer()
                CardView(
                    isAccepted:"yes",
                    title: "Lendi",
                    subtitle: "Buss Lendi",
                    imageUrl: "https://randomuser.me/api/portraits/women/0.jpg",
                       onAccept: {
                           print("Accepted")
                       },
                       onReject: {
                           print("Rejected")
                       }
                   )
                Spacer()
            }
            VStack{
                Spacer()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                if isDataLoaded {
                    HStack {
                        Spacer()
                        Text("Match Mate")
//                            .font(.system(size: 20))
                            .font(.custom("DancingScript-Bold", size: 25))
                            .foregroundColor(.white)
                            .frame(alignment: .bottom)
                        Spacer()
                    }
                    .padding(.vertical,8)
                    .background(Color.pink)
                    .frame(maxWidth: .infinity)
                    .matchedGeometryEffect(id: "splash", in: nameSpace)
                    .frame(height: 45)
                    Spacer()
                    
                } else {
                    HStack {
                        Spacer()
                        Text("Match Mate")
                            .font(.custom("DancingScript-Bold", size: 40))
                            .foregroundColor(.white)
                        Spacer()
                    }
//                    .padding()
                    
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity,alignment:.center)
                    .background(Color.pink)
                    .matchedGeometryEffect(id: "splash", in: nameSpace)
                    
                }
            }
            
        }
        .background(Color.pink.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                withAnimation(.bouncy){
                    isDataLoaded = true
                }
            }
        }
        }
}

#Preview {
    helperView()
}
