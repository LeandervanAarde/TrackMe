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
    @StateObject private var viewmodel = ImageUploadManager()
    
    init(){
        getUserDetails()
    }

    func createNewUser(userName: String, userId: String){
        var data:[String: Any] = [:]
        data["username"] = userName
        data["latitude"] = ""
        data["longitude"] = ""
        data["foundFriends"] = 0
        data["profileImage"] = "https://firebasestorage.googleapis.com/v0/b/trackme-7f739.appspot.com/o/default-avatar-profile-icon-symbol-for-website-vector-46547084.jpg?alt=media&token=5ef3ec6e-5ccf-45b9-91df-a5a36ccb701e"
        data["fromWhere"] = ""
        data["Friends"] = 0
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
    
    func updateUserProfileImage(profileImage: URL?) async throws{
        do{
            guard let imageURL = profileImage else {
                print("Error invalid URL")
                return
            }
            
            try await viewmodel.uploadImage(fromURL: imageURL){ [self](uri, error) in
                if let error = error{
                    print("Error desc:", error.localizedDescription)
                    
                } else if let uri = uri{
                    print("uploaded image:", uri)
                    let docref = db.collection("users").document(getUserId())
                    
                    docref.updateData(["profileImage": uri.absoluteString]){error in
                        if let error = error{
                            print("error here", error.localizedDescription)
                        } else{
                            print("Document updated.")
                        }
                    }
                    
                }
            }
        }
    }

}


