//
//  HomeViewModel.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/17/22.
//

import Foundation
import CloudKit

// option + click to show info
// Optional: Desired keys to limit data to query. Results limit to limit number of records
// operation.desiredKeys = ["title", "description", ...] // returns only title and description
@MainActor
class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        let predicate = NSPredicate(value: true) // all records
        let query = CKQuery(recordType: "Post", predicate: predicate)
        query.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false) // if there were 1000 items, this would sort the databse and return 50 recent items.
        ]
        
        var returnedPosts: [Post] = []
        
        let operation = CKQueryOperation(query: query)
        
        operation.resultsLimit = 50
        
        // gets called each for each record
        operation.recordMatchedBlock = { recordID, result in
            switch result {
            case .success(let record):
                guard let title = record["title"] as? String else { return }
                returnedPosts.append(Post(record: record, title: title))
//                print("Adding post...")
            case.failure(let error):
                print("Error fetching post: \(error)")
            }
        }
        
        // closure to execute after cloudkit retrieves all records
        operation.queryResultBlock = { result in
            switch result {
            case .success(let cursor):
                DispatchQueue.main.async { // not sure why i have to call this when i have @MainActor
                    self.posts = returnedPosts
                }
                print("Finished adding all posts!")
            case .failure(let error):
                print(error)
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)    // executes operation
    }
    
    func deletePost(record: CKRecord) async {
        let container = CKContainer.default()
        let database = container.publicCloudDatabase
        do {
            try await database.deleteRecord(withID: record.recordID)
            posts = posts.filter {$0.record.recordID != record.recordID} // delete post locally aswell (better than re-fetching data to update ui)
            print("Deleted post!")
        } catch {
            print("Error deleting post")
        }
    }
}
