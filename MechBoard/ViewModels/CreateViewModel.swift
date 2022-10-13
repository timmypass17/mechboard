//
//  CreateViewModel.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/18/22.
//

import Foundation
import CloudKit

class CreateViewModel: ObservableObject {
    @Published var post: Post = Post()
    
    // note: 1. cloudkit automatically creates recordType
    //       2. user must be logged into icloud to save records, else nothing happens when creating
    func createPost() async {
        
        // note: cloudkit automatically creates recordType
        let record = CKRecord(recordType: "Post")   // 1. Create a record (object being stored onto icloud)
        record.setValuesForKeys([                   // 2. Set values of record, can't store objects, just break Keyboard object into parts
            "title": post.title,
            "caption": post.caption,
            "likes": post.likes,
            "size": post.keyboard.size.rawValue,
            "keycaps": post.keyboard.keycaps,
            "switches": post.keyboard.switches,
            "case": post.keyboard.case,
            "plate": post.keyboard.plate,
            "foam": post.keyboard.foam
        ])
        // 3. Save to icloud (public database)
        await savePost(record: record)
    }
    
    func savePost(record: CKRecord) async {
        let container = CKContainer.default()
        let database = container.publicCloudDatabase
        
        do {
            try await database.save(record)
            print("Added record successfully!")
        } catch {
            // show alert for user to log in to icloud?
            print("Error saving record")
            print(error)
        }
    }
}
