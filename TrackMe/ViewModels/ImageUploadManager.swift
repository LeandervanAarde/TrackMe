//
//  ImageUploadManager.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 18/08/2023.
//

import Foundation
import UIKit

class ImageUploadManager: ObservableObject {

@Published var imgUri: URL?
    
    private let storageManager: StorageManager = StorageManager()
    @Published var imageUri: URL?
    
    func uploadImage(fromURL imageURL: URL?, completion: @escaping (URL?, Error?) -> Void) {
           guard let imageURL = imageURL else {
               print("No image")
               completion(nil, nil)
               return
           }
           
           guard let image = UIImage(contentsOfFile: imageURL.path) else {
               print("Invalid image.")
               completion(nil, nil)
               return
           }
           
           storageManager.uploadImage(image: image) { [weak self] (uri, error) in
               if let error = error {
                   print("Error uploading image:", error)
                   completion(nil, error)
               }
               
               if let uri = uri {
                   DispatchQueue.main.async {
                       self?.imgUri = uri
                       completion(uri, nil)
                   }
               }
           }
       }
    
    func saveImageToTemporaryDirectory(image: UIImage) async -> URL? {
        do {
            let temporaryDirectory = FileManager.default.temporaryDirectory
            let timestamp = Date().timeIntervalSince1970
            let fileName = "image_\(timestamp).jpg"
            let imageURL = temporaryDirectory.appendingPathComponent(fileName)
            let imageData = image.jpegData(compressionQuality: 0.8)
            try imageData?.write(to: imageURL)
            return imageURL
        } catch {
            print("Error saving image to temporary directory: \(error)")
            return nil
        }
    }
}
