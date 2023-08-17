//
//  SplashScreenNavigation.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 05/08/2023.
//

import SwiftUI

class NavigationNavigationVm: ObservableObject {
    @Published var nextScreen: AnyView = AnyView(EmptyView())
    @ObservedObject var authVm: AuthenticationViewModel = AuthenticationViewModel()
    @Published  var userID: String = ""
    
    init(){
        fetchUserID()
        
    }
    
    func fetchUserID() {
        authVm.getUserId { userID in
               DispatchQueue.main.async {
                   self.userID = userID
                   print(userID)
               }
           }
       }
       
    func navigateToNextScreen(hasOpened: Bool) {
        if hasOpened {
            if(userID == ""){
                nextScreen = AnyView(LoginView())
            }
            nextScreen = AnyView(ContentView())
        } else {
            nextScreen = AnyView(Onboarding())
        }
    }
}
