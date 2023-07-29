//
//  SplashScreen.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 29/07/2023.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isRotating: Double = -25.0
    private var loadingItem: [String] = ["Loading Data...", "Finding Friends...", "Searching for North..."]
    let randomInt: Int = Int.random(in: 0..<3)
    var body: some View {
        VStack{
            
            Text("Track me")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            Spacer()
                .frame(height: 20)
            Text("🧭")
                .font(.system(size: 120))
                .rotationEffect(Angle(degrees: isRotating))
                .onAppear{
                    withAnimation(.linear(duration: 1).speed(0.4).repeatForever(autoreverses: true)){
                        isRotating = 25.0
                    }
                }
            Ellipse()
                .fill(
                    LinearGradient(gradient: Gradient(stops: [
                        Gradient.Stop(color: Color("DarkGreeb"), location: 0.7),
                        Gradient.Stop(color: .black, location: 1.1),
                    ]), startPoint: .top, endPoint: .bottom)
                )
                .frame(width: 120, height: 25)
                .padding(.top, -70)
                .foregroundColor(.clear)
            
            Text(loadingItem[randomInt])
                .font(.caption)
                .bold()
                .foregroundColor(.white)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(   LinearGradient(gradient: Gradient(stops: [
            Gradient.Stop(color: Color("Green"), location: 0.1),
            Gradient.Stop(color: .black, location: 1.6),
        ]), startPoint: .top, endPoint: .bottom))
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
