//
//  SelectGroupTypeView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 10/08/2023.
//

import SwiftUI

struct SelectGroupTypeView: View {
    var body: some View {
        VStack{
        Text("Create Group")
            .font(.title)
            .frame(maxWidth: .infinity)
            
        Text("What kind of Group is this?")
            .font(.subheadline)
            .frame(maxWidth: .infinity)
            
            Grid(){
                GridRow{
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        VStack{
                            Image("Festivals")
                                .resizable()
                            Text("Festivals")
                        }
                        
                    }
                    
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        VStack{
                            Image("Parties")
                                .resizable()
                            Text("Parties")
                        }
                    }
                }
                
                GridRow{
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        VStack{
                            Image("Stores")
                                .resizable()
                            Text("Stores/Malls")
                        }
                        
                    }
                    
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        VStack{
                            Image("Restaurants")
                                .resizable()
                            Text("Restaurants")
                        }
                    }
                }
                
                GridRow{
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        VStack{
                            Image("Excersize")
                                .resizable()
                            
                            Text("Gyms and Excersze")
                        }
                    }
                    
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        VStack{
                            Image("StudyGroup")
                                .resizable()
                             
                            Text("Education/Study")
                        }
                    }
                }

            } // End of Grid

        } // End of VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
    }
}

struct SelectGroupTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGroupTypeView()
    }
}
