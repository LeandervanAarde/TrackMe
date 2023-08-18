//
//  FirebaseUsersViewModel.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 09/08/2023.
//
import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import SwiftUI

class GroupsViewModel: ObservableObject{
    
    private var db = Firestore.firestore()
    public func createNewGroup(groupName: String, groupImage: String, code: String){
        let data: GroupsModel = GroupsModel(GroupName: groupName, GroupImage: groupImage, GroupCode: code)
        
        print("DATA TO BE PARSED", data)
    }

    func randomStringGenerator(length: Int) -> String {
        let base = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        var s = ""
        for _ in 0..<length {
            s.append(base.randomElement()!)
        }
        return s
    }
}


