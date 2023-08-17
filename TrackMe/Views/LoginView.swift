//
//  LoginView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 29/07/2023.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

//ContentView()
//    .environment(\.managedObjectContext, persistenceController.container.viewContext)
struct LoginView: View {
    let gradient = Gradient(colors: [Color("Green"), Color("DarkGreen")])
    @State private var scaleVal: Double = 0.0
    @State private var rotation: Double = 0.0
    @State var isActive: Bool = false

    
    @ObservedObject var viewModel: AuthenticationViewModel = AuthenticationViewModel()
    
    var body: some View {

        NavigationView{
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
                
                SignInWithAppleButton{requeest in
                    viewModel.handleSignInWithAppleRequest(requeest)
                } onCompletion: { result in
                    viewModel.handleSignInWithAppleCompletion(result)
                    if viewModel.authenticationState == .authenticated {
                        isActive = true 
                    }

                }
                .frame(maxHeight: 50)
                .padding(.horizontal, 50)
                Spacer()
                    .frame(height: 20)
                
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
            .background(
                NavigationLink(
                    destination: ContentView(),
                    isActive: $isActive,
                    label: { EmptyView() }
                )
            )

            .padding(0)
        }
    }
}
    
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
   
