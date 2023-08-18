//
//  NavigationBar.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 05/08/2023.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        TabView{
            DashboardView()
            .tabItem{
                Label("Home", systemImage: "house")
            }
            
//            Text("Countries")
//            ProfileView()
//                .tabItem{
//                Label("Countries", systemImage: "globe.europe.africa")
//            }
            
            ContentView()
            .tabItem{
                Label("Favorites", systemImage: "heart")
            }
            
            Groups()
            .tabItem{
                Label("Feed", systemImage: "note.text")
            }
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
