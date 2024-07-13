//
//  GeneralErrorView.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import SwiftUI

struct GeneralErrorView: View {
    var errorMessage: String
    var onRetry: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red)
                .frame(width: 80, height: 80)
                .padding(.top, 20)
            
            Text("Oops! Something went wrong")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Text(errorMessage)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
            if let onRetry = onRetry {
                Button(action: onRetry) {
                    Text("Retry")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.pink.opacity(0.05))
        .edgesIgnoringSafeArea(.all)
    }
}
#Preview {
    GeneralErrorView(errorMessage: "Unknown error") {
        
    }
}
