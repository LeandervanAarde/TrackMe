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

class UsersViewModel: ObservableObject{
    
    private var db = Firestore.firestore()
    @Published var userDetails: personModel?
    
    init(){
        getUserDetails()
    }

    func createNewUser(userName: String, userId: String){
        var data:[String: Any] = [:]
        
        data["username"] = userName
        db.collection("users").document(userId).setData(data)
    }
    
    func getUserId() -> String {
        return Auth.auth().currentUser?.uid ?? "No user id found"
    }
    func getUserDetails() {
        let userId = getUserId()
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching user details:", error.localizedDescription)
                return
            }

            if let document = document, document.exists {
                if let userData = try? document.data(as: personModel.self) {
                    self.userDetails = userData
                } else {
                    print("Problem with decoding document \(userId)")
                }
            }
        }
    }

}


