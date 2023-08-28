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
    @Published var userGroups: [GroupsModel] = []
    @Published var individualGroup: GroupsModel?
    @Published var groupMembers: [personModel] = []
    
    init(){
        getAllUserGroups {documents, error in
            if let error = error {
                print(error)
            } else if let documents = documents {
                for document in documents {
                    _ = document.data()
                    if let group = try? document.data(as: GroupsModel.self) {
                        self.userGroups.append(group)
                    }
                }
            }
        }
    }
    
    public func createNewGroup(groupName: String, groupImage: String, code: String) -> Bool{
        let data: [String: Any] = [
            "GroupName": groupName,
            "GroupImage": groupImage,
            "GroupMembers": [Auth.auth().currentUser?.uid ?? ""],
            "GroupCode": code
        ]
        
        db.collection("groups").addDocument(data: data){ error in
            if let error = error{
                print("error adding doc", error)
            } else{
                print("group \(groupName) added to db")
            }
        }
        
        return true
    }

    public func getAllUserGroups(completion: @escaping ([DocumentSnapshot]?, Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(nil, nil) //
            return
        }

        db.collection("groups").whereField("GroupMembers", arrayContains: userID).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching user groups:", error)
                completion(nil, error)
            } else {
                completion(snapshot?.documents, nil)
            }
        }
    }
    
    public func getIndividualGroup(id: String){
        db.collection("groups").document(id).getDocument{[weak self] document, error in
            guard let self = self else {return}
            
            if let error = error {
                print("Error in retrieving document with group details", error.localizedDescription)
                return
            }
            if let document = document, document.exists{
                if let groupData = try? document.data(as: GroupsModel.self){
                    self.individualGroup = groupData
                    if let groupMembers = groupData.GroupMembers{
                        for member in groupMembers {
                            getUserDetails(userId: member)
                        }
                    }
                    
                } else{
                    print("Problem with decoding the Group \(id)")
                }
            }
        }
    }
    
    private func getUserDetails(userId: String) {
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching user details:", error.localizedDescription)
                return
            }
            if let document = document, document.exists {
                if let userData = try? document.data(as: personModel.self) {
                    self.groupMembers.append(userData)
                } else {
                    print("Problem with decoding document \(userId)")
                }
            }
        }
    }
    
    public func joinNewGroup(code: String){
        let userID = Auth.auth().currentUser?.uid
        let groupsRef = db.collection("groups")
        
        groupsRef.whereField("GroupCode", isEqualTo: code).getDocuments{(snapshot, error) in
            
            if let error = error{
                print("Error \(error.localizedDescription)")
            }
            
            guard let doc = snapshot?.documents.first else {
                print("Error for group with code \(code)")
                return
            }
            
            let groupID = doc.documentID
            let groupRef = groupsRef.document(groupID)
            
            groupRef.updateData(["GroupMembers": FieldValue.arrayUnion([userID as Any])]){error in
                if let error = error {
                    print("Error upating \(error.localizedDescription)")
                } else {
                    print("updated doc")
                    
                    
                }
            }
        }
    }
    
    func leaveGroup(groupId: String){
        let userID = Auth.auth().currentUser?.uid
        let groupsRef = db.collection("groups").document(groupId)
        
        groupsRef.updateData(["GroupMembers": FieldValue.arrayRemove([userID as Any])]){error in
            if let error = error {
                print("Error upating \(error.localizedDescription)")
            } else {
                print("updated doc")
            }
        }
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


