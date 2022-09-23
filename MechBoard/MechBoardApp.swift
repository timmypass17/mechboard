//
//  MechBoardApp.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/2/22.
//

import SwiftUI

@main
struct MechBoardApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var createViewModel = CreateViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                HomeView()
//                    .badge(3)
                    .tabItem {
                        Label("Market", systemImage: "banknote")
                    }
                CreateView()
                    .tabItem {
                        Label("", systemImage: "plus")
                    }
                    .environmentObject(CreateViewModel())
                HomeView()
//                    .badge("14") or .badge(14)
                    .tabItem {
                        Label("Inbox", systemImage: "tray")
                    }
                HomeView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
            .alert(isPresented: $authViewModel.showAlert) {
                Alert(
                    title: Text("Please Login to iCloud."),
                    message: Text("MechBoardApp uses iCloud authentication.")
                )
            }
            .environmentObject(authViewModel)   // inject viewmodel into children views
            .environmentObject(homeViewModel)
            
        }
    }
}

extension Color {
    static let ui = Color.UI()
    
    struct UI {
        let background = Color("background")
    }
}
