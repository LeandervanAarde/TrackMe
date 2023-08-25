//
//  JoinGroupView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 25/08/2023.
//

import SwiftUI

struct JoinGroupView: View {
	@State private var groupCodeEntry: String = ""
    var body: some View {
		
        VStack(spacing: -120){
            Image("DashImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: 300)
            
			VStack(alignment: .leading){
				HStack{
					Spacer()
					Image("Point")
						.resizable()
						.frame(maxWidth: 30, maxHeight: 50)
						.scaledToFit()
	
					Text("Join a new group")
						.foregroundColor(Color("Green"))
						.font(.title2)
					Spacer()
				}
				.padding(.top, 15)
				Spacer()
				TextField("Enter group code", text: $groupCodeEntry)
					.background(RoundedRectangle(cornerRadius: 10).fill(.white))
					.foregroundColor(Color("Green"))
				Divider()
					.frame(minHeight: 1)
					.overlay(Color("Green"))
			
				
				Spacer()
				
				HStack{
					Spacer()
					Button(action: {
						print("Hello world! code \(groupCodeEntry)")
					}) {
						Text("Join new Group!")
					 
						Image(systemName: "person.3.fill")
					}
					.padding(.vertical, 9)
					.padding(.horizontal, 10)
					.background(Color("Green"))
					.foregroundColor(.white)
					.cornerRadius(8)
					.frame(maxHeight: 20)
					Spacer()
				}
            }
			.padding(45)
			
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .cornerRadius(radius: 120.0, corners: [.topLeft])
        }
        .padding(0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.white)
    }
}

struct JoinGroupView_Previews: PreviewProvider {
    static var previews: some View {
        JoinGroupView()
    }
}
