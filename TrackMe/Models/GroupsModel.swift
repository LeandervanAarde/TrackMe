//
//  Groups.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 10/08/2023.
//

import Foundation
//import FirebaseFirestoreSwift

struct GroupsModel: Decodable , Identifiable, Encodable{
    var id: String
    var GroupName: String
    var GroupMembers: [String]?
    var GroupImage: String
    var GroupCode: String
}
