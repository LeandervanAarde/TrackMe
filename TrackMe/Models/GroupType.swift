//
//  GroupType.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 17/08/2023.
//

import Foundation

struct GroupType: Hashable{
    var type: String
    var image: String
}


var groups: [GroupType] = [
    GroupType(type: "Festivals", image: "Festivals"),
    GroupType(type: "Parties", image: "Parties"),
    GroupType(type: "Stores/Malls", image: "Stores"),
    GroupType(type: "Restaurants", image: "Restaurants"),
    GroupType(type: "Gyms and Excersize", image: "Excersize"),
    GroupType(type: "Education/Study Groups", image: "StudyGroup")
]
