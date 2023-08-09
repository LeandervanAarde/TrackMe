//
//  ProfileView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 05/08/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            HStack{
                Image("deleteMe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(maxHeight: 170)
                
                VStack{
                    Text("Beetle Juice")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Green"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                    
                    HStack{
                        Image(systemName: "mappin")
                            .foregroundColor(.red)
                            
                        Text("Roodepoort")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("Green"))
                    } // End of pindrop HStack
                }
            } // End of profile HStack
            
            HStack{
                VStack{
                    Text("2")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("Groups")
                        .font(.subheadline)
                      
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .frame(maxWidth: 1, maxHeight: 100)
                    .overlay(Color("Green"))
                    .padding(.leading, 70)

                
                VStack{
                    Text("2")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("Groups")
                        .font(.subheadline)
                      
                }

                
                Divider()
                    .frame(maxWidth: 1, maxHeight: 100)
                    .overlay(Color("Green"))
                    .padding(.leading, 70)
       
                
                
                VStack{
                    Text("2")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("Groups")
                        .font(.subheadline)
                      
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding(.horizontal, 60)// End of information HStack
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //End of VStack
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
