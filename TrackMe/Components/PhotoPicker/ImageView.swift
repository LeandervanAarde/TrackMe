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
                    .aspectRatio(contentMode: .fill) // Use fill content mode
                    .frame(maxHeight: 60)
                    .clipShape(Circle())
            } else {
                if let profileImageURL = URL(string: userVm.userDetails?.profileImage ?? "") {
                    AsyncImage(url: profileImageURL) { phase in
                        switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            case .failure(_):
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            case .empty:
                                ProgressView()
                                    .frame(width: 100, height: 100)
                        @unknown default:
                            fatalError()
                        }
                    }
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100)
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
