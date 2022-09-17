//
//  ContentView.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/2/22.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
//            Text("Is signed in to iCloud: \(authViewModel.isSignedInToiCloud.description)")
//            Text("Error: \(authViewModel.error)")
//            Text("Username: \(authViewModel.userName)")
//            Text("Permission Status: \(authViewModel.permissionStatus.description)")
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach($homeViewModel.posts) { $post in
                        PostItem(post: $post)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
            .environmentObject(HomeViewModel())
    }
}

