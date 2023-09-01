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
                    if let doc = document.data(){
                        if document.data() != nil  {
                            let name = doc["GroupName"] as? String
                            let members = doc["GroupMembers"] as? [String]
                            let image = doc["GroupImage"] as? String
                            let code = doc["GroupCode"] as? String
                            
                            self.userGroups.append(GroupsModel(GroupName: name ?? "", GroupMembers: members ?? [""] , GroupImage: image ?? "", GroupCode: code ?? ""))
                        }
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
                
                
                
                if let groupData = document.data(){
                    
                    let name = groupData["GroupName"] as? String
                    let members = groupData["GroupMembers"] as? [String]
                    let image = groupData["GroupImage"] as? String
                    let code = groupData["GroupCode"] as? String
                    
                    self.individualGroup = GroupsModel(GroupName: name ?? "", GroupMembers: members ?? [""] , GroupImage: image ?? "", GroupCode: code ?? "")
                    if let groupMembers = members{
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
        db.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                print("Error fetching user details:", error.localizedDescription)
                return
            }
            
            if let document = document, document.exists {
                if document.data() != nil {
                    DispatchQueue.main.async { [weak self] in
                        let friends  = document["Friends"] as? Int
                        let foundFriends = document["foundFriends"] as? Int
                        let fromWhere = document["FromWhere"] as? String
                        let latitude = document["latitude"] as? String
                        let longitude = document["longitude"] as? String
                        let profileImage = document["profileImage"] as? String
                        let username = document["username"] as? String
                        
                        
                        self?.groupMembers.append(personModel(username: username ?? "", latitude: latitude ?? "", longitude: longitude ?? "", foundFriends: foundFriends ?? 0, profileImage: profileImage ?? "", fromWhere: fromWhere ?? "", Friends: friends ?? 0))
                    }
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


