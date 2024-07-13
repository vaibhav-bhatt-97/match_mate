//
//  appBar.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import SwiftUI

struct appBar: View {
    @Binding var isDataLoaded:Bool
    @Namespace var nameSpace
    @State private var size = 0.5
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.pink)
            if isDataLoaded {
                HStack {
                    Spacer()
                    Text("Match Mate")
//                        .scaleEffect(size)
                        .font(.custom("DancingScript-Bold", size: 35))
                        .foregroundColor(.white)
                        .frame(alignment: .bottom)
//                        .onAppear{
//                            withAnimation(.bouncy(duration: 1)){
//                                self.size = 1
//                            }
//                        }
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
                        .scaleEffect(size)
                        .font(.custom("DancingScript-Bold", size: 50))
                        .foregroundColor(.white)
                        .onAppear{
                            withAnimation(.bouncy(duration: 1)){
                                self.size = 1.5
                            }
                        }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity,alignment:.center)
                .background(Color.pink)
                .matchedGeometryEffect(id: "splash", in: nameSpace)
                
            }
        }
    }
}
