//
//  TrackMeApp.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 29/07/2023.
//

import SwiftUI
import FirebaseCore

////
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}


@main
struct TrackMeApp: App {
    init() {
        FirebaseApp.configure()
    }
    let persistenceController = PersistenceController.shared    

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            SelectGroupTypeView()
            
//            SplashScreen()
//            DashboardView()
            
        }
        
    }
}




