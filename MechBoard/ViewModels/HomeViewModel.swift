//
//  HomeViewModel.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/17/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var posts = Post.samplePosts
}
