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
        NavigationView {
            VStack {
                Text("My Groups")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                
                NavigationLink(destination: SelectGroupTypeView(), label:{
                    Text("Create new Group")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(Color("Green"))
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                        .frame(maxHeight: 50)
                })
                
                Spacer().frame(maxHeight: 10)
                
                List {
                    ForEach($userGroups) { document in
                        NavigationLink(
                            destination: IndividualGroupView(groupId: document.id),
                            label: {
                            GroupView(
                                image: document.GroupImage,
                                name: document.GroupName
                                )
                            }
                        )
                    }
                    .onDelete { indices in
                        for index in indices {
                            let group = userGroups[index]
                            if let docID = group.id {
                                GroupManager.leaveGroup(groupId: group.id!)
                            }
                        }
                    }
                }
                .padding(0)
                .listStyle(PlainListStyle()) // Added list style
            }
            .padding(0)
            .background(Color.white) // Apply white background to the VStack
            .onAppear {
                GroupManager.getAllUserGroups { documents, error in
                    if let error = error {
                        print(error)
                    } else if let documents = documents {
                        GroupManager.userGroups = documents.compactMap { document in
                            try? document.data(as: GroupsModel.self)
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    userGroups = GroupManager.userGroups
                    print(GroupManager.userGroups)
                    currentGroupID = userGroups[0].id
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
