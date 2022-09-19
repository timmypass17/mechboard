//
//  Post.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/17/22.
//

import Foundation
import CloudKit

struct Post {
    var title: String
    var record: CKRecord
    
    func timeCreatedFormatted() -> String{
        guard let creationDate = record.creationDate else { return "just now" }
        
        // ask for the full relative date
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full

        // get exampleDate relative to the current date
        let relativeDate = formatter.localizedString(for: creationDate, relativeTo: Date.now)
        
        return relativeDate
    }
}

extension Post {
    static let samplePosts = [
        Post(title: "A simple setup, but it works so well.", record: CKRecord(recordType: "Post")),
        Post(title: "How about custom cables with display?", record: CKRecord(recordType: "Post")),
        Post(title: "Spent over $500 and converted 3 more friends into the hobby. After touching my SA caps they already wanted more", record: CKRecord(recordType: "Post")),
        Post(title: "Purple Owl, a laster cut custom 60%", record: CKRecord(recordType: "Post"))
    ]
}
