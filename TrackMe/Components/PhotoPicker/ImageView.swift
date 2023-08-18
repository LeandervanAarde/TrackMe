//
//  ImageView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 18/08/2023.
//
import SwiftUI
struct ImageView: View {
    @ObservedObject var userVm: UsersViewModel = UsersViewModel()
    var image: Image?

    var body: some View {
        Group {
            if let avatarImage = image {
                avatarImage
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(maxHeight: UIScreen.main.bounds.height / 8)
                    .clipShape(Circle())
                    .padding()
            } else {
                if let profileImageURL = URL(string: userVm.userDetails?.profileImage ?? "") {
 
                    AsyncImage(url: profileImageURL) { phase in
                        switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.gray)
                                    .padding()
                                    .clipShape(Circle())
                            case .failure(_):
                    
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(.gray)
                                    .frame(maxHeight: UIScreen.main.bounds.height / 8)
                                    .padding()
                                    .clipShape(Circle())
                        case .empty:
      
                            ProgressView()
                                .frame(maxHeight: UIScreen.main.bounds.height / 8)
                                .padding()
                        }
                    }
                } else {
              
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(maxHeight: UIScreen.main.bounds.height / 8)
                        .padding()
                        .clipShape(Circle())
                }
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            Circle()
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
