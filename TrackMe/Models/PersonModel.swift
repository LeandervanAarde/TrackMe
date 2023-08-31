//
//  PersonModel.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 10/08/2023.
//
import Foundation
import FirebaseFirestoreSwift
struct personModel:  Identifiable, Decodable{
    
    @DocumentID var id: String?
    var username: String
    var latitude: String
    var longitude: String
    var foundFriends: Int
    var profileImage: String
    var fromWhere: String
    var Friends: Int
}
