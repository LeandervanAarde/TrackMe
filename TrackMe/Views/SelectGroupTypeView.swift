//
//  SelectGroupTypeView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 10/08/2023.
//

import SwiftUI

struct SelectGroupTypeView: View {
    @State var selectedGroupType: GroupType = GroupType()
    private var groups: [GroupType] = [
        GroupType(type: "Festivals", image: "Festivals"),
        GroupType(type: "Parties", image: "Parties"),
        GroupType(type: "Stores/Malls", image: "Stores"),
        GroupType(type: "Restaurants", image: "Restaurants"),
        GroupType(type: "Gyms and Excersize", image: "Excersize"),
        GroupType(type: "Education/Study Groups", image: "StudyGroup")
    ]
    var body: some View {
        VStack{
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
                            Button {
                                self.selectedGroupType = GroupType(type: groups[index].type, image: groups[index].image)
                                print(groups[index])
                            } label: {
                                NavigationLink(destination: GroupCreationView(groupType: $selectedGroupType)) {
                                    VStack{
                                        Image(groups[index].image ?? "")
                                            .resizable()
                                            .scaledToFit()
                                        Text(groups[index].type ?? "")
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
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

struct SelectGroupTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGroupTypeView()
    }
}
