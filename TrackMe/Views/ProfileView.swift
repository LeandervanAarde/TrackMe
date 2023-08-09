//
//  ProfileView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 05/08/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            HStack{
                Image("deleteMe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(maxHeight: 170)
                
                VStack{
                    Text("Beetle Juice")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Green"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                    
                    HStack{
                        Image(systemName: "mappin")
                            .foregroundColor(.red)
                            
                        Text("Roodepoort")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("Green"))
                    } // End of pindrop HStack
                }
            } // End of profile HStack
            
            HStack(spacing: 13) {
                Spacer()
                
                Text("2 \n Groups")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 70)
                    .foregroundColor(Color("Green"))
                    .lineSpacing(1)
                
                Divider()
                    .frame(maxWidth: 1, maxHeight: 80)
                    .overlay(Color("Green"))
                    .padding(.vertical, 20) // Add space between text and divider
                
                Text("2 \n Found")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 70)
                    .foregroundColor(Color("Green"))
                
                Divider()
                    .frame(maxWidth: 1, maxHeight: 80)
                    .overlay(Color("Green"))
                    .padding(.vertical, 20) // Add space between text and divider
                
                Text("2 \nFriends")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 70)
                    .foregroundColor(Color("Green"))
                
                Spacer()
            }

            .frame(maxWidth: .infinity)// End of information HStack
            
            Spacer()
                        
            HStack{
                Button(action: {}){
                    Text("Add profile Image")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(Color("LightGray"))
                        .foregroundColor(Color("ProfileButtonTextGray"))
                        .cornerRadius(8)
                        .frame(maxHeight: 20)
                }
            } //HStack for buttons
            
            Spacer()
              
            //Spacer for button and green stack
            VStack {
                Text("GROUPS")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                HStack{
                    VStack{
                        Image(systemName: "plus")
                            .resizable()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .foregroundColor(Color.white)
                        
                        Text("Create Group")
                            .foregroundColor(Color.white)
                            .font(.caption2)
                    } //End of HStakc containing Button 1
                    
                    Spacer() //Spacer for buttons
                    
                    VStack{
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .foregroundColor(Color.white)
                        
                        Text("Join Group")
                            .foregroundColor(Color.white)
                            .font(.caption2)
                    } //End of VStack for Button 2
                } //End of HStack containing Create and join
                
                Button(action: {}){
                    Text("View my Groups")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .foregroundColor(Color("Green"))
                        .cornerRadius(8)
                        .frame(maxHeight: 20)
                } //End of button
                
            }
            .frame(maxWidth: .infinity, maxHeight: 140, alignment: .top)
            .padding(10)
            .padding(.bottom, 10)
            .background(Color("Green"))
            .cornerRadius(radius: 45.0, corners: [.topLeft, .topRight])
            //End of Green Rounded corners VStack
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.light)
        //End of VStack
    }
}

struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
