//
//  GroupMemberView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 26/08/2023.
//

import SwiftUI

struct GroupMemberView: View {
    @Binding var userName: String
    @Binding var profileImage: String
    @Binding var latitude: String
    @Binding var longitude: String
    var body: some View {
        VStack{
            HStack(alignment: .center) {
                
                if let imageURL = URL(string: profileImage) {
                          AsyncImage(url: imageURL) { phase in
                              switch phase {
                                  case .success(let image):
                                      image
                                          .resizable()
                                          .scaledToFill()
                                          .frame(maxWidth: 50, maxHeight: 50)
                                          .aspectRatio(contentMode: .fit)
                                          .foregroundColor(.gray)
                                          .padding()
                                          .clipShape(Circle())
                                  case .failure(_):
                          
                                      Image(systemName: "person.fill")
                                          .resizable()
                                          .scaledToFill()
                                          .foregroundColor(.gray)
                                          .frame(maxHeight: 70)
                                          .padding()
                                          .clipShape(Circle())
                              case .empty:
            
                                  ProgressView()
                                      .frame(maxHeight: 70)
                                      .padding()
                              @unknown default:
                                  fatalError()
                              }
                          }
                      } else {
                          Image(systemName: "person.fill")
                              .resizable()
                              .scaledToFill()
                              .foregroundColor(.gray)
                              .frame(maxHeight: 70)
                              .padding()
                              .clipShape(Circle())
                      }
 
                        VStack(alignment: .leading) {
                            Text(userName)
                                .font(.body)
                                .fontWeight(.bold)
                            
                            Text(latitude)
                                .fontWeight(.light)
                            
                            Text(longitude)
                                .fontWeight(.light)
                        }
                            
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .background(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .alignmentGuide(.leading) { _ in 0 }
            
            Divider()
        }
        .padding(.trailing, 10)


    }
}

struct GroupMemberView_Previews: PreviewProvider {
    static var previews: some View {
        GroupMemberView(userName: .constant("Riaan van Aarde"), profileImage: .constant("Hey"), latitude: .constant("1902"), longitude: .constant("192.000"))
    }
}
