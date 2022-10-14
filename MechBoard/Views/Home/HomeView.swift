//
//  ContentView.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/2/22.
//

import SwiftUI
import CoreData
import CloudKit

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var isShowingSheet = false
    @State var selectedPost: Post = Post()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach($homeViewModel.posts, id: \.record.recordID) { $post in
                        PostItem(post: $post, onClickOption: handleOption)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
            .sheet(isPresented: $isShowingSheet, onDismiss: {}) {
                VStack {
                    Button("Delete", role: .destructive, action: {
                        Task {
                            await homeViewModel.deletePost(record: selectedPost.record)
                            dismiss()
                        }
                    })
                }
                
            }
            .listStyle(.plain)
            .buttonStyle(.plain)
            .refreshable {
                print("Refreshing")
                homeViewModel.fetchPosts()
            }
            .navigationTitle("mechboard")
        }
    }
    
    func handleOption(post: Post)  {
        selectedPost = post
        isShowingSheet.toggle()
    }
    
    func dismiss() {
        isShowingSheet = false
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
            .environmentObject(HomeViewModel())
    }
}

//            Text("Is signed in to iCloud: \(authViewModel.isSignedInToiCloud.description)")
//            Text("Error: \(authViewModel.error)")
//            Text("Username: \(authViewModel.userName)")
//            Text("Permission Status: \(authViewModel.permissionStatus.description)")
