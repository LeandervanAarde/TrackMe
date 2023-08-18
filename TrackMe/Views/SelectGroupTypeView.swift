//
//  SelectGroupTypeView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 10/08/2023.
//

import SwiftUI

struct SelectGroupTypeView: View {
    @State var selectedGroupType: GroupType = groups[1]
    @State private var navigateToGroupCreation = false

    var body: some View {
        VStack {
            Text("Create Group")
                .font(.title)
                .frame(maxWidth: .infinity)
            
            Text("What kind of Group is this?")
                .font(.subheadline)
                .frame(maxWidth: .infinity)
            
            ForEach(0..<groups.count/2) { row in
                HStack {
                    ForEach(0..<2) { column in
                        let index = row * 2 + column
                        if index < groups.count {
                            Button(action: {
                                self.selectedGroupType = groups[index]
                                self.navigateToGroupCreation = true
                            }) {
                                VStack {
                                    Image(groups[index].image)
                                        .resizable()
                                        .scaledToFit()
                                    Text(groups[index].type)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .background(NavigationLink("", destination: GroupCreationView(groupType: $selectedGroupType), isActive: $navigateToGroupCreation))
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
    }
}
