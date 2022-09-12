//
//  AuthViewModel.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/2/22.
//

import Foundation
import CloudKit

// Note: @MainActor automatically dispatch UI updates on the main queue.
//       Removes need to manually call DisptachQueue.main.async{} when updating views asynchronously.
// Why? UI can only be updated on the main queue. So updating views on a background queue is bad.

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var permissionStatus: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    
    init() {
        Task {
            await getiCloudStatus()     // Check if user is logged into iCloud
            await requestPermission()   // Show popup to user to allow other user's to find them using email
            await discoveriCloudUser()  // Fetch iCloud data about user
        }
    }
    
    // User needs to be signed into an iCloud Account
    private func getiCloudStatus() async {
        do {
            let status = try await CKContainer.default().accountStatus()
            switch status {
            case .couldNotDetermine:
                self.error = CloudKitError.iCloudAccountNotDetermined.rawValue
            case .available:
                self.isSignedInToiCloud = true // updating change on background thread, @MainActor fixes that
            case .restricted:
                self.error = CloudKitError.iCloudAccountRestricted.rawValue
            case .noAccount:
                self.error = CloudKitError.iCloudAccountNotFound.rawValue
            case .temporarilyUnavailable:
                self.error = CloudKitError.iCloudAccountUnavailable.rawValue
            @unknown default:
                self.error = CloudKitError.iCloudUnknown.rawValue
            }
        } catch {
            print("Error calling getiCloudStatus: \(error)")
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountNotFound
        case iCloudAccountUnavailable
        case iCloudUnknown
    }
    
    func requestPermission() async {
        do {
            let status = try await CKContainer.default().requestApplicationPermission([.userDiscoverability])
            switch status {
            case .initialState:
                break
            case .couldNotComplete:
                break
            case .denied:
                break
            case .granted:
                self.permissionStatus = true
            @unknown default:
                break
            }
        } catch {
            print("Error requesting permission")
        }
    }
    
    // Can discover users by record id, email, phone number. Can look up multible users at once.
    func discoveriCloudUser() async {
        do {
            let uid = try await CKContainer.default().userRecordID()    // get id of current user
            let user = try await CKContainer.default().userIdentity(forUserRecordID: uid)   // get user's iCloud info using user's id
            
            if let name = user?.nameComponents?.givenName { // unwrap optional user if let
                self.userName = name
            }
            
            // user?.lookupInfo?.emailAddress (Note: can't get user's email unless we get user identity using email. we currently looking up users using userRecordID)
        } catch {
            print("Error calling discoveriCloudUser: \(error)")
        }
    }
}
