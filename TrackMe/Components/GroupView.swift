//
//  GroupView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 28/08/2023.
//

import SwiftUI

struct GroupView: View {
    var body: some View {
        VStack{
            HStack{
                Image("Festivals")
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 90)
                    .scaledToFit()
                Spacer()
                
                Text("Group Name Here")
                Spacer()
                
                VStack{
                    Image(systemName: "person.fill")
                    Text("3")
                }
            }
            Divider()
        }
        .padding(.horizontal,10)
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
