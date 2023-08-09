//
//  Groups.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 10/08/2023.
//

import Foundation

struct GroupsModel: Identifiable {
    var id = UUID()
    var GroupName: String
    var GroupMembers: [personModel]
}
