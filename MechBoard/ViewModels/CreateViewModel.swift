//
//  CreateViewModel.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/18/22.
//

import Foundation
import CloudKit
import SwiftUI
import PhotosUI

// Note: we used Data instead of Image
// Why? 1. Image onyl supports .png
//      2. Data can be converted into UIImage into Image
class CreateViewModel: ObservableObject {
//    @Published var post: Post?
    @Published var post: Post = Post()

    
    enum ImageState {
        case empty, loading(Progress), success(Data), failure(Error)   // value associated with enums
    }
    
    @Published private(set) var imageState: ImageState = .empty
    @Published private var selectedImageData: Data?

    // set imageSelect to .empty if image is nil, other wise, start loading the image
    @Published var imageSelection: PhotosPickerItem? {
        didSet { // didSet is called whenever the property imageSelection is assigned a new value. (true even if new value is same as old value)
            if let imageSelection { // unwrap optional
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }

    // Load asset data using transferable
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else { return }
                switch result {
                case .success(let data?):
                    // Handle the success case with the image.
                    self.selectedImageData = data
                    self.imageState = .success(data)
                case.success(nil):
                    // Handle the success case with an empty value.
                    print("Unsupported format, only .png")
                    self.imageState = .empty
                case .failure(let error):
                    // Handle the failure case with the provided error.
                    // A failure can occur when the system attempts to retrieve the data.
                    // For example, if the picker tries to download data from iCloud Photos without a network connection.
                    print("Error image: \(error)")
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    // note: 1. cloudkit automatically creates recordType
    //       2. user must be logged into icloud to save records, else nothing happens when creating
    func createPost() async {
        
        guard let data = selectedImageData else { return }  // User must have an image!
        
        // 1. Create a record (object being stored onto icloud)
        // note: cloudkit automatically creates recordType
        let record = CKRecord(recordType: "Post")
        
        // 2. Set values of record, can't store objects, just break Keyboard object into parts
        record.setValuesForKeys([
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
        
        print(data.description)
        // Create photo url. (Can't get url directly from photo, must place data in a new location and make a url from that)
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appending(path: "keyboard.png") else { return }
        
        do {
            try data.write(to: url)
            record["image"] = CKAsset(fileURL: url)
            
            // 3. Save to icloud (public database)
            await savePost(record: record)
        } catch {
            print(error)
        }
        // print(path) [file:///var/mobile/Containers/Data/Application/B4280FB2-A341-44D9-B674-82291F51D7DF/Library/Caches/]
        
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
