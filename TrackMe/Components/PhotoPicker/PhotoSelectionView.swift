//
//  PhotoSelectionView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 18/08/2023.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct PhotoSelectionView: View {
    @Binding var avatarItem: PhotosPickerItem?
    @Binding var selectedImageURL: URL?

    var body: some View {
        PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
            .tint(.accentColor)
            .frame(maxWidth: .infinity, maxHeight: 20)
            .buttonStyle(.borderedProminent)
    }
}

struct PhotoSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSelectionView(avatarItem: .constant(nil), selectedImageURL: .constant(nil))
    }
}
