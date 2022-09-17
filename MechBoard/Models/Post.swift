//
//  Post.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/17/22.
//

import Foundation

struct Post: Identifiable {
    var id = UUID()
    var title: String
}

extension Post {
    static let samplePosts = [
        Post(title: "A simple setup, but it works so well."),
        Post(title: "How about custom cables with display?"),
        Post(title: "Spent over $500 and converted 3 more friends into the hobby. After touching my SA caps they already wanted more"),
        Post(title: "Purple Owl, a laster cut custom 60%")
    ]
}
