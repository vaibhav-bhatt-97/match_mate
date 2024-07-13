//
//  NetworkErrorView.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import SwiftUI

struct NetworkErrorView: View {
    @Binding var showNetworkErrorView:Bool
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "wifi.exclamationmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .padding(.bottom, 20)
            
            Text("No Network Connection")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("Please check your internet connection and try again.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            Button(action: {
                showNetworkErrorView=false
            }) {
                Text("Go Offline Mode")
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            Spacer()
        }
        .padding()
        .background(Color.pink.opacity(0.05))
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    NetworkErrorView(showNetworkErrorView: Binding<Bool>)
//}
