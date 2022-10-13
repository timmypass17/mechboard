//
//  Post.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/17/22.
//

import Foundation
import CloudKit

struct Post {
    var record: CKRecord = CKRecord(recordType: "Post")
    var title: String = ""
    var caption: String = ""
    var likes: [String] = [] // user's id, could use CKRecord.Reference? kinda complicated
    var keyboard: Keyboard = Keyboard()
    
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
        Post(
            record: CKRecord(recordType: "Post"),
            title: "dalgona",
            caption: "from a calming and refreshing whipped coffee to a fun korean childhood favorite, dalgona is a popular confectionary based from south korea."
            ),
        Post(record: CKRecord(recordType: "Post"), title: "How about custom cables with display?"),
        Post(record: CKRecord(recordType: "Post"), title: "Spent over $500 and converted 3 more friends into the hobby. After touching my SA caps they already wanted more"),
        Post(record: CKRecord(recordType: "Post"), title: "Purple Owl, a laster cut custom 60%")
    ]
}
