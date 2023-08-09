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
    var vm : NavigationNavigationVm = NavigationNavigationVm()
    @AppStorage("hasOpened") var hasOpened : Bool = false
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack{
            if(self.isActive){
                vm.nextScreen
            } else{
                VStack{
                    
                    Text("Track me")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height: 20)

                    
                    ZStack{
                        Image("CompassOuter")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 190, alignment: .center)
                            .padding(.bottom, 29)
                        Image("CompassInner")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 125)
                            .rotationEffect(Angle(degrees: isRotating), anchor: .center)
                            .onAppear {
                                withAnimation(.linear(duration: 1).speed(0.4).repeatForever(autoreverses: true)) {
                                    isRotating = 25.0
                                }
                            }
                    }
                    Spacer()
                        .frame(height: 30)
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
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                withAnimation{
                    vm.navigateToNextScreen(hasOpened: hasOpened)
                        self.isActive = true
                    }
                UserDefaults.standard.set(false, forKey: "hasOpened")
                
                }
            }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
