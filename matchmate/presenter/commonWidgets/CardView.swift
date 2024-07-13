import SwiftUI

struct CardView: View {
    var isAccepted: String
    var title: String
    var subtitle: String
    var imageUrl: String
    var onAccept: () -> Void
    var onReject: () -> Void
    
    @State private var offset = CGSize.zero
    @State private var color: Color = .clear
    
    private func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            print("Declined")
//            offset = CGSize(width: -500, height: 0)
            onReject()
            offset = .zero
        case 150...500:
            print("Accepted")
//            offset = CGSize(width: 500, height: 0)
            onAccept()
            offset = .zero
        default:
            offset = .zero
        }
    }
    
    private func changeColor(width: CGFloat) {
        switch width {
        case -500...(-20):
            print("Declined")
            color = .red.opacity(0.4)
        case 20...500:
            print("Accepted")
            color = .green.opacity(0.4)
        default:
            color = .clear
        }
    }
    
    var body: some View {
        ZStack {
            // Background image from URL
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .cornerRadius(20)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            } else {
                // Fallback for earlier iOS versions
                Text("Image loading not supported")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray)
                    .cornerRadius(20)
            }
            
            VStack {
                Spacer()
                VStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding()
                
                HStack(spacing: 50) {
                    if isAccepted == "" {
                        // Reject button
                        Button(action: onReject) {
                            Image(systemName: "hand.thumbsdown.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.pink)
                                .clipShape(Circle())
                                .frame(width: 60, height: 60)
                        }
                        
                        // Accept button
                        Button(action: onAccept) {
                            Image(systemName: "hand.thumbsup.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .frame(width: 60, height: 60)
                        }
                    } else {
                        isAccepted == "yes"
                        ?
                        Text("Accepted")
                            .frame(width: 300, height: 60)
                            .foregroundColor(Color.white)
                            .background(Color.green.opacity(0.8))
                            .cornerRadius(20)
                        :
                        Text("Declined")
                            .frame(width: 300, height: 60)
                            .foregroundColor(Color.white)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(20)
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.35), Color.clear]),
                    startPoint: .bottom,
                    endPoint: .center
                )
                .cornerRadius(20)
            )
            Rectangle()
                .foregroundColor(color)
        }
        .frame(width: 350, height: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .pink.opacity(0.2), radius: 5, x: 2, y: 2)
        .padding()
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 30)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                        changeColor(width: offset.width)
                    }
                }
        )
    }
}
