//
//  Groups.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 05/08/2023.
//

import SwiftUI
import MapKit

struct Groups: View {
    @StateObject var GroupManager: GroupsViewModel = GroupsViewModel()
    @State private var navigateToIndividual = false
    @State var currentGroupID: String?
    var body: some View {
        @State var userGroups = GroupManager.userGroups
        NavigationView{
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
                } // end of button
                Spacer()
                    .frame(maxHeight: 10)
                VStack(alignment: .leading, spacing: 10)  {
                    ForEach(0..<userGroups.count, id: \.self) { row in
                        HStack {
                            ForEach(0..<2) { column in
                                let index = row * 2 + column
                                if index < userGroups.count {
//                                    Button(action: {
//                                        self.currentGroupID = userGroups[index].id
//                                        self.navigateToIndividual = true
//                                        print(self.currentGroupID)
//                                    }) {
//                                        NavigationLink {
//                                            IndividualGroupView(groupId: $currentGroupID)
//                                        } label: {
//                                            VStack {
//                                                Image(userGroups[index].GroupImage)
//                                                    .resizable()
//                                                    .scaledToFit()
//                                                    Text(userGroups[index].GroupName)
//                                                }
//                                                .frame(maxWidth: .infinity)
//                                        }
//                                    }
//                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Button(action: {
                                        self.currentGroupID = userGroups[index].id
                                        self.navigateToIndividual = true
                                        print(String(describing: currentGroupID))
                                    }) {
                                        NavigationLink {
                                            IndividualGroupView(groupId: $currentGroupID)
                                        } label: {
                                                                                     VStack {
                                                                                        Image(userGroups[index].GroupImage)
                                                                                           .resizable()
                                                                                            .scaledToFit()
                                                                                         Text(userGroups[index].GroupName)
                                                                                }
                                                                                       .frame(maxWidth: .infinity)
                                            .frame(maxWidth: .infinity)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                   
                                }
                            }
                        }
                    }
                } // end of VStack
                .onAppear{
                    GroupManager.getAllUserGroups { documents, error in
                            if let error = error {
                                print(error)
                            } else if let documents = documents {
                                GroupManager.userGroups = documents.compactMap { document in
                                try? document.data(as: GroupsModel.self)
                                    }
                            }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                        userGroups = GroupManager.userGroups
                        print(GroupManager.userGroups)
                        currentGroupID = userGroups[0].id
                    }
                }
                Spacer()
            } // End of VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
        }
        }
    
    }
//
//struct Groups_Previews: PreviewProvider {
//    static var previews: some View {
//        Groups()
//    }
//}
