//
//  CreateView.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/17/22.
//

import SwiftUI

struct CreateView: View {
    @EnvironmentObject var createViewModel: CreateViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            TextField("Title", text: $createViewModel.post.title)
            Button("Create", action: { Task { await handleCreateButton() } })
                .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Share your keyboard!")
    }
    
    private func handleCreateButton() async {
        homeViewModel.posts.insert(self.createViewModel.post, at: 0) // add post locally
        await createViewModel.createPost()
    }
    
    
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
