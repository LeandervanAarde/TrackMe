//
//  GroupCreationView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 17/08/2023.
//

import SwiftUI

struct GroupCreationView: View {
    @Binding var groupType: GroupType
    @State var groupTypeString: String = ""
    @ObservedObject var groupVm: GroupsViewModel = GroupsViewModel()
    var randomCode: String = GroupsViewModel().randomStringGenerator(length: 6)
    @State var showCode: Bool = false
    var body: some View {
        VStack{
            
            Image(groupType.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300)
             
            Spacer()
                .frame(height: 20)
        
            if(showCode){
                HStack {
                    Button(action: {
                        UIPasteboard.general.string = "Join my group on Track me! \nCode: \(randomCode)"
                    }) {
                        Text("Copygroup code: \(randomCode)")
                     
                        Image(systemName: "doc.on.doc")
                    }
                    .padding(.vertical, 9)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .cornerRadius(8)
                    .frame(maxHeight: 20)
                }
            }else {
                TextField("Group name", text: $groupTypeString)
                     .background(RoundedRectangle(cornerRadius: 10).fill(Color("Green").opacity(0.0)))
                     .foregroundColor(Color.white)
                 Divider()
                  .frame(height: 1)
                  .padding(.horizontal, 30)
                  .background(Color.white)
                
                Spacer()
                    .frame(height: 30)
                
                Button(action: {showCode = groupVm.createNewGroup(groupName: groupTypeString, groupImage: groupType.image , code: randomCode)}) {
                    HStack{
                        Text("Create Group")
                            .padding(.vertical, 7)
                            .padding(.horizontal, 10)
                            .background(Color("Yellow"))
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                            .frame(maxHeight: 20)
                    }
                }
                
                Spacer()
                    .frame(height: 30)
                
                Button(action: {}) {
                    Text("Cancel Group")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                        .frame(maxHeight: 20)
                }

            }

     

        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(stops: [
                Gradient.Stop(color: Color("Green"), location: 0.2),
                Gradient.Stop(color: Color("LoginTriangleGreen"), location: 0.79),
            ]), startPoint: .bottomTrailing, endPoint: .topLeading))
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

//struct GroupCreationView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupCreationView(groupType: .constant(GroupType(type: "festival", image: "Festivals")))
//    }
//}
