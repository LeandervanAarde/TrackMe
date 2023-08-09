//
//  SplashScreenNavigation.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 05/08/2023.
//

import SwiftUI

class NavigationNavigationVm: ObservableObject {
    @Published var nextScreen: AnyView = AnyView(EmptyView())

    func navigateToNextScreen(hasOpened: Bool) {
        if hasOpened {
            nextScreen = AnyView(LoginView())
        } else {
            nextScreen = AnyView(Onboarding())
        }
    }
}
