//
//  StorageManager.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 18/08/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit


class StorageManager: ObservableObject{
    var storage = Storage.storage()
    let timeStamp = Date().timeIntervalSince1970
    
    public func uploadImage(image: UIImage, completion: @escaping (URL? , Error?) -> Void){
        let storageRef = storage.reference().child("profileImages/image_\(timeStamp).jpg")
        let imageData = image.jpegData(compressionQuality: 0.8)
        let metaData = StorageMetadata()
        metaData.contentType = "iamge/jpg"
        
        if let data = imageData {
            storageRef.putData(data, metadata: metaData) {(metaDdata, error) in
                storageRef.downloadURL{(url, error) in
                    storageRef.downloadURL{(url, error) in
                        if let error = error{
                            print("Error retrieving downloadURL", error)
                            completion(nil, error)
                            return
                        }
                        
                        if let downloadURL = url{
                            print("downloadURl", downloadURL)
                            completion(downloadURL, nil)
                        }
                    }
                }
            }
        }
    }
}
