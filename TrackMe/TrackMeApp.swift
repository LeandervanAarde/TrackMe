//
//  TrackMeApp.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 29/07/2023.
//

import SwiftUI

@main
struct TrackMeApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            LoginView()

//            NavigationBar()
        }
    }
}




