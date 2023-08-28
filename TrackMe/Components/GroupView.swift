//
//  GroupView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 28/08/2023.
//

import SwiftUI

struct GroupView: View {
    @Binding var image: String
    @Binding var name: String

    var body: some View {
        VStack{
            HStack{
                Image(image)
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 90)
                    .scaledToFit()
                Spacer()
                Text(name)
                Spacer()
            }
        }
        .padding(.horizontal,10)
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(image: .constant("Festivals") , name: .constant("FestiNinja"))
    }
}
