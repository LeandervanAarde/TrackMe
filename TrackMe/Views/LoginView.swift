//
//  LoginView.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 29/07/2023.
//

import SwiftUI

struct LoginView: View {
    let gradient = Gradient(colors: [Color("Green"), Color("DarkGreen")])

   
    var body: some View {
        VStack{
            
            Text("WELCOME TO")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading , 80)
            
            Text("TRACK ME")
                .font(.system(size: 40))
                .bold()
                .foregroundColor(.white)
            
            Image("SignIn")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 350)
            
            Spacer()
                .frame(height: 30)
            
            Button("SIGN UP"){
                print("PRESSED SIGN UP")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 11)
            .background(
                LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: .white, location: 0.1),
                    Gradient.Stop(color: Color("Green"), location: 1.3),
                ]), startPoint: .top, endPoint: .bottom)
            )
            .clipShape(Capsule())
            
            Spacer()
                .frame(height: 15)
            
            
            Text("ALREADY HAVE AN ACCOUNT?")
                .foregroundColor(.white)
            
            Spacer()
                .frame(height: 15)
            
            Button("SIGN IN"){
                print("PRESSED SIGN UP")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 11)
            .background(
                LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: .white, location: 0.1),
                    Gradient.Stop(color: Color("Green"), location: 1.3),
                ]), startPoint: .top, endPoint: .bottom)
            )
            .clipShape(Capsule())
 
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
        

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        

        return path
    }
}
