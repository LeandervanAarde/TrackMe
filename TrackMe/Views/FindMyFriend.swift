//
//  FindMyFriend.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 31/08/2023.
//
import SwiftUI

struct FindMyFriend: View {
    @Binding var userImage: String
    @Binding var userName: String
    @Binding var userLat: String
    @Binding var userLong: String

    var body: some View {
        VStack {
            Spacer()
            HStack {
                AsyncImage(url: URL(string: userImage)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 60, maxHeight: 60)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                    case .failure(_):
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.gray)
                            .frame(maxHeight: 60)
                            .clipShape(Circle()) 
                    case .empty:
                        ProgressView()
                            .frame(maxHeight: 70)
                    @unknown default:
                        fatalError()
                    }
                }
                .scaledToFill()
                .frame(maxWidth: 60, maxHeight: 60)


                Text("Finding \(userName)")
                    .font(.title)
                    .foregroundColor(.white)
            }
            Spacer()

            Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 110, height: 110)

            Spacer()

            Button(action: {}){
                Text("Found \(userName) ⭐️")
                    .font(.title2)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .foregroundColor(Color("Green"))
                    .cornerRadius(8)
                    .frame(maxHeight: 20)
            } //End of button
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .background(
            LinearGradient(gradient: Gradient(stops: [
                Gradient.Stop(color: Color("Green"), location: 0.2),
                Gradient.Stop(color: Color("LoginTriangleGreen"), location: 0.79),
            ]), startPoint: .bottomTrailing, endPoint: .topLeading))
    }
}

struct FindMyFriend_Previews: PreviewProvider {
    static var previews: some View {
        FindMyFriend(userImage: .constant("https://firebasestorage.googleapis.com:443/v0/b/trackme-7f739.appspot.com/o/profileImages%2Fimage_1693086953.519913.jpg?alt=media&token=4b511d29-c098-4d76-88cd-0dbb4261a580"), userName: .constant("Julia"), userLat: .constant("-26.000530743054476"), userLong: .constant("28.006480392094705"))
    }
}
