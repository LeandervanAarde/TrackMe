//
//  IndividualGroupModel.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 24/08/2023.
//

import Foundation
import FirebaseFirestoreSwift
struct IndividualGroupModel: Decodable {
    var GroupInformation: GroupsModel
    var usersInformation: [personModel]
}
