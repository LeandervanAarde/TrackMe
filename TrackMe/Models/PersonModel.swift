//
//  PersonModel.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 10/08/2023.
//
import Foundation

struct personModel:   Decodable{
    var username: String
    var latitude: String
    var longitude: String
    var foundFriends: Int
    var profileImage: String
    var fromWhere: String
    var Friends: Int
}
