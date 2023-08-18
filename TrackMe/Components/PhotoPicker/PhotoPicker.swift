//
//  PhotoPicker.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 18/08/2023.
//

import PhotosUI
import SwiftUI
struct PhotoPicker: View {
    @State private var model = PhotoPickerModel()
    
    @Binding var imageUrl: URL?
    @StateObject private var imghelper = ImageUploadManager()
    @State private var imgUri: URL?
        var body: some View {
            VStack {
                ImageView(image: model.image)
                Spacer()
                    .frame(height: 10)
                PhotoSelectionView(avatarItem: $model.item, selectedImageURL: $imageUrl)
            }
            .onChange(of: model.item) { _ in
                Task {
                    if let data = try? await model.item?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            model.image = Image(uiImage: uiImage)
                            if let imageURL = await imghelper.saveImageToTemporaryDirectory(image: uiImage) {
                                imageUrl = imageURL
                            
                                print(imageURL)
                            }
                            return
                        }
                    }
                    print("Failed")
                }
            }
            .padding()
            .frame(maxHeight: UIScreen.main.bounds.height / 3)
        }
    }
struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker(imageUrl: .constant(nil))
    }
}
