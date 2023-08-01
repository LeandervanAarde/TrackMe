//
//  LoginView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 29/07/2023.
//

import SwiftUI

struct LoginView: View {
    let gradient = Gradient(colors: [Color("Green"), Color("DarkGreen")])
    @State private var scaleVal: Double = 0.0
    @State private var rotation: Double = 0.0
    @State var isActive: Bool = false
   
    var body: some View {
        ZStack{
            if !self.isActive {
                SplashScreen()
            } else{
                VStack{
                    Text("WELCOME TO")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading , 80)
                        .foregroundColor(Color.white)
                    
                    Text("TRACK ME")
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(Color("Yellow"))
                    
                    Image("SignIn")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 350)
                        .scaleEffect(scaleVal)
                        .rotationEffect(Angle(degrees: rotation))
                    
                        .onAppear{
                            withAnimation(.linear(duration: 1).speed(0.4)){
                                scaleVal = 0.8
                            }
                            withAnimation(.linear(duration: 1.5).speed(0.4).repeatForever(autoreverses: true)){
                                scaleVal = 0.92
                            }
                        }
                
                    Spacer()
                        .frame(height: 30)
                    
                    
                    HStack {
                        Image("AppleLogo")
                            .resizable()
                            .frame(maxWidth: 18, maxHeight: 20)
                            .padding(10)
                        // Make the Image stretch to full width
                        
         
                        
                        Text("Sign in with Apple Account")
                            .font(.system(size: 15))
                            .padding(.vertical, 20)
                            .padding(.trailing, 10)
                            .foregroundColor(Color.black)
                             // Make the Text stretch to full width
                    }
                   
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(10)
                    
                    HStack{
                        VStack{
                            Divider()
                                .frame(minHeight: 1)
                                .overlay(Color.white)
                                .padding(.leading, 50)
                                
                        }
                            Text("OR")
                            .foregroundColor(Color.white)
                        
                        VStack{
                            Divider()
                                .frame(minHeight: 1)
                                .overlay(Color.white)
                                .padding(.trailing, 50)
                        }
               
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button("Log in with email"){
                        
                    }
                    .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(stops: [
                        Gradient.Stop(color: Color("Green"), location: 0.2),
                        Gradient.Stop(color: Color("LoginTriangleGreen"), location: 0.79),
                    ]), startPoint: .bottomTrailing, endPoint: .topLeading))

                .padding(0)
                }
            }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                withAnimation{
                    self.isActive = true
                }
            }
        }
    }
}
    
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
   
