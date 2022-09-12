//
//  ContentView.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/2/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var viewmodel = AuthViewModel()
    
    var body: some View {
        VStack {
            Text("Is signed in: \(viewmodel.isSignedInToiCloud.description)")
            Text("Error: \(viewmodel.error)")
            Text("Username: \(viewmodel.userName)")
            Text("Permission Status: \(viewmodel.permissionStatus.description)")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
