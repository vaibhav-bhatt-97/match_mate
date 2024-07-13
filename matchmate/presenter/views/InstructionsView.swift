//
//  InstructionsView.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import SwiftUI

struct InstructionsView: View {
    @State var arrowRight : Bool = false
    @State var arrowLeft : Bool = false
    @State var arrowUp : Bool = false
    @Namespace var nameSpace
    var animationDuration = 3
    @State private var stopAnimation:Bool = false
    @State private var screenNumber: Int = 0
    var completion: () -> Void
    private func startAnimation(){
        withAnimation(.bouncy(duration: TimeInterval(animationDuration))){
            arrowRight = true
        }
        if !stopAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(animationDuration)) {
                arrowRight = false
                startAnimation()
            }
        }
    }
    var body: some View {
        ZStack{
            Spacer()
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
            VStack{
                Spacer()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                Spacer()
                switch screenNumber{
                case 0:
                    if arrowRight {
                        HStack{
                            Image(systemName: "arrowshape.right.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                        }
                        .matchedGeometryEffect(id: "splash", in: nameSpace)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                    }else{
                        HStack{
                            Image(systemName: "arrowshape.right.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                        }
                        .matchedGeometryEffect(id: "splash", in: nameSpace)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()                    }
                case 1:
                    if arrowRight {
                        HStack{
                            Image(systemName: "arrowshape.left.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                        }
                        .matchedGeometryEffect(id: "splash", in: nameSpace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }else{
                        HStack{
                            Image(systemName: "arrowshape.left.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                        }
                        .matchedGeometryEffect(id: "splash", in: nameSpace)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .padding()                    }
                default:
                    if arrowRight {
                        VStack{
                            Image(systemName: "arrowshape.up.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                        }
                        .matchedGeometryEffect(id: "splash", in: nameSpace)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding()
                    }else{
                        VStack{
                            Image(systemName: "arrowshape.up.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                        }
                        .matchedGeometryEffect(id: "splash", in: nameSpace)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding()                    }
                }
                switch screenNumber{
                    case 0:
                        Text("Swipe RIGHT to accept a match.")
                            .foregroundColor(.white)
                            .font(.title2)
                    case 1:
                        Text("Swipe LEFT to decline a match.")
                            .foregroundColor(.white)
                            .font(.title2)
                    default:
                        Text("Swipe UP to load more matches.")
                            .foregroundColor(.white)
                            .font(.title2)
                }
                
                HStack{
                    Button(action: {
                        if screenNumber<2 {
                            screenNumber+=1
                        }else{
                            stopAnimation = true
                            completion()
                            print("jald hi khatma ho jaega")
                        }
                    }, label: {
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .border(Color.white)
                        
                    })
                }.padding()
                Spacer()
            }.padding()
            
            
        }
        .background(Color.black.opacity(0.5))
        .onAppear{
            startAnimation()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
//
//#Preview {
//    InstructionsView()
//}
