//
//  Groups.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 05/08/2023.
//

import SwiftUI
import MapKit

struct Groups: View {
    
    private var myGroups: [GroupsModel] = [
        GroupsModel(GroupName: "Dancing Queen", GroupMembers: nil, GroupImage: "Festivals", GroupCode: "1232132"),
        GroupsModel(GroupName: "Natashas night out", GroupMembers: nil, GroupImage: "Parties", GroupCode: "1232132"),
        GroupsModel(GroupName: "Shoppin!", GroupMembers: nil, GroupImage: "Stores", GroupCode: "1232132"),
        GroupsModel(GroupName: "Yum time", GroupMembers: nil, GroupImage: "Restaurants", GroupCode: "1232132"),
        GroupsModel(GroupName: "Rave out!", GroupMembers: nil, GroupImage: "Festivals", GroupCode: "1232132")
    ]
    var body: some View {
        VStack{
        Text("My Groups")
            .font(.title)
            .frame(maxWidth: .infinity)
            
            Button(action: {}){
                Text("Create new Group")
                    .padding(.vertical, 7)
                    .padding(.horizontal, 10)
                    .background(Color("Green"))
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    .frame(maxHeight: 50)
            }
            Spacer()
            VStack(spacing: 10) {
                ForEach(0..<myGroups.count) { index in
                    if index % 2 == 0 {
                        HStack(spacing: 10) {
                            Button {
                                print("Edit button was tapped")
                            } label: {
                                VStack {
                                    Image(myGroups[index].GroupImage)
                                        .resizable()
                                    Text(myGroups[index].GroupName)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.5) // Set the width to 50%

                            if index + 1 < myGroups.count {
                                Button {
                                    print("Edit button was tapped")
                                } label: {
                                    VStack {
                                        Image(myGroups[index + 1].GroupImage)
                                            .resizable()
                                        Text(myGroups[index + 1].GroupName)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.5) // Set the width to 50%
                            }
                        }
                    }
                }
            } // end of VStack


        } // End of VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
 
        .padding(.horizontal, 20)
        }
    
    }

struct Groups_Previews: PreviewProvider {
    static var previews: some View {
        Groups()
    }
}
