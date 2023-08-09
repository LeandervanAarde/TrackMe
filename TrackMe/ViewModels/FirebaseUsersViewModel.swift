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

class UsersViewModel: ObservableObject{
    
    private var db = Firestore.firestore()
    
    func createNewUser(userName: String, userId: String){
        var data:[String: Any] = [:]
        
        data["username"] = userName
        db.collection("users").document(userId).setData(data)
    }
}
