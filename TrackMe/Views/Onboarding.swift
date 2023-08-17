//
//  Onboarding.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 02/08/2023.
//

import SwiftUI

struct Onboarding: View {
    @State private var scaleVal: Double = 0.0
    @State private var rotation: Double = 0.0
    @ObservedObject var vm = OnBoardingViewModel()
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    Image(vm.OnBoardingSteps[vm.counter].imageSource)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(contentMode: .fit)
                            .scaleEffect(scaleVal)
                            .onAppear {
                                withAnimation(.linear(duration: 1).speed(0.4)) {
                                    scaleVal = 0.8
                                }
                                withAnimation(.linear(duration: 1.5).speed(0.4).repeatForever(autoreverses: true)) {
                                    scaleVal = 0.92
                                }
                            }
                        
                        Text(vm.OnBoardingSteps[vm.counter].heading)
                            .foregroundColor(Color.white)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer().frame(height: 15)
                        
                        Text(vm.OnBoardingSteps[vm.counter].content)
                            .font(.body)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        
                    }
                    .onAppear {
                        if !vm.showNextScreen {
                            vm.onBoardingTimer()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(stops: [
                            Gradient.Stop(color: Color("Green"), location: 0.2),
                            Gradient.Stop(color: Color("LoginTriangleGreen"), location: 0.79),
                        ]), startPoint: .bottomTrailing, endPoint: .topLeading)
                    )
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
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $vm.showNextScreen, content: LoginView.init)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
