//
//  OnboardingVm.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 02/08/2023.
//
import SwiftUI

import Foundation


class OnBoardingViewModel: ObservableObject {
    @Published var OnBoardingSteps: [OnBoardingModel] = []
    @Published var counter: Int = 0
    @Published var showNextScreen = false
    
    
    init(){
        onBoarding()
    }
    
    private func onBoarding(){
        
        OnBoardingSteps.append(
            OnBoardingModel(id: 1, imageSource: "Connections", heading: "Connect wit others", content: "Never loose a friend again at large festivals, get directions right too them!"))
        
        OnBoardingSteps.append(
            OnBoardingModel(id: 2, imageSource: "OnBoarding2", heading: "Based on shared connections", content: "Create groups and share locations to find each other"))
        
    }
    
    func hasOpenedFunc(hasOpened: Bool) {
        if !hasOpened {
           return  onBoarding()
        } else {
            return self.showNextScreen = true
        }
    }
    
    func onBoardingTimer(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10){
            withAnimation{
                if(self.counter >= self.OnBoardingSteps.count - 1){
                    self.showNextScreen = true
                    self.navigateToNextScreen()
                } else{
                    self.counter += 1
                    self.onBoardingTimer()
                }
            }
        }
    }
    
    func navigateToNextScreen() {
        DispatchQueue.main.async {
            self.showNextScreen = true
        }
    }
}
    
