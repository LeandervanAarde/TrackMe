//
//  PhotoPicker.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 18/08/2023.
//

import SwiftUI
import PhotosUI
struct PhotoPicker: View {
    @Binding var avatarItem: PhotosPickerItem?
    @Binding var selectedImageURL: URL?
    @StateObject private var firebaseStorage = StorageManager()
    @StateObject private var photoManager = ImageUploadManager()
    
    var body: some View {
        PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
            .tint(.accentColor)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 3)
            .buttonStyle(.borderedProminent)
    }
}

//struct PhotoPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoPicker()
//    }
//}
