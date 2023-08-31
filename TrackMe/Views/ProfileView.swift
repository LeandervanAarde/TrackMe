//
//  ProfileView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 05/08/2023.
//

import SwiftUI
import CoreLocation

struct ProfileView: View {
    @StateObject var locationManager = LocationManager()
    @ObservedObject var userVm: UsersViewModel = UsersViewModel()
    @ObservedObject var groupsVm: GroupsViewModel = GroupsViewModel()
    var image: Image?
    @State private var model = PhotoPickerModel()
    @State private var selectedImageURL: URL?
    @State private var groupCount: Int = 0;
    @State private var locationName: String = ""
  
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    PhotoPicker(imageUrl: $selectedImageURL)
                        .onAppear {
                            if selectedImageURL == nil || selectedImageURL!.absoluteString.isEmpty {
                                selectedImageURL = URL(string: "default_profile_image_url_here")
                            }
                        }
                    VStack{
                        Text(userVm.userDetails?.username ?? "")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("Green"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 25)
                        
                        HStack{
                            Image(systemName: "mappin")
                                .foregroundColor(.red)
                                
                            Text(locationName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color("Green"))
                                .task {
                                    if let lastLocation = locationManager.location {
                                        let location = CLLocation(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
                                        await locationManager.reverseGeocodeLocation(location) { name in
                                            self.locationName = name
                                        }
                                    }
                                }
          
                        } // End of pindrop HStack
                    }
                } // End of profile HStack
                
                HStack(spacing: 13) {
                    Spacer()
                    
                    Text("\(groupCount) \n Groups")
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 70)
                        .foregroundColor(Color("Green"))
                        .lineSpacing(1)
                    
                    Divider()
                        .frame(maxWidth: 1, maxHeight: 80)
                        .overlay(Color("Green"))
                        .padding(.vertical, 20) // Add space between text and divider
                    
                    Text("\(userVm.userDetails?.foundFriends ?? 1) \n Found")
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 70)
                        .foregroundColor(Color("Green"))
                    
                    Spacer()
                }

                .frame(maxWidth: .infinity)// End of information HStack
                Spacer()
                            
                Spacer()
                  
                //Spacer for button and green stack
                VStack {
                    Text("GROUPS")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack{
                   
                            NavigationLink(destination: SelectGroupTypeView() , label: {
                            VStack{
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(maxWidth: 30, maxHeight: 30)
                                    .foregroundColor(Color.white)
                                
                                Text("Create Group")
                                    .foregroundColor(Color.white)
                                    .font(.caption2)
                            } //End of HStakc containing Button 1
                            })
                   
                        
                        Spacer() //Spacer for buttons
                        
                        NavigationLink(destination: JoinGroupView(), label: {
                            VStack{
                                Image(systemName: "plus.app")
                                    .resizable()
                                    .frame(maxWidth: 30, maxHeight: 30)
                                    .foregroundColor(Color.white)
                                
                                Text("Join Group")
                                    .foregroundColor(Color.white)
                                    .font(.caption2)
                            } //End of VStack for Button 2
                        })
                    } //End of HStack containing Create and join
                }
                .frame(maxWidth: .infinity, maxHeight: 140, alignment: .top)
                .padding(10)
                .padding(.bottom, 10)
                .background(Color("Green"))
                .cornerRadius(radius: 45.0, corners: [.topLeft, .topRight])
                //End of Green Rounded corners VStack
            }
            .preferredColorScheme(.light)
            .onAppear{
                groupsVm.getAllUserGroups { documents, error in
                    if let error = error {
                        print(error)
                    } else if let documents = documents {
                        groupCount = documents.count
                        }
                    }
                }
        }
        .onChange(of: selectedImageURL) { newValue in
            Task {
                if let newURL = newValue {
                    try await userVm.updateUserProfileImage(profileImage: newURL)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.light)
    }
}
