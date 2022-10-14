//
//  CreateView.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/17/22.
//

import PhotosUI
import SwiftUI

struct CreateView: View {
    @EnvironmentObject var createViewModel: CreateViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
        
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Post")) {
                    CreateTextField(title: "Title", placeholder: "Title", text: $createViewModel.post.title)
                    
                    CreateTextField(title: "Description", placeholder: "Description", text: $createViewModel.post.caption)
                }
                
                Section(header: Text("Choose an image") /** , footer: Text("*only accepts .png files").italic() **/) {
                    KeyboardImage(imageState: createViewModel.imageState)
                        .overlay(alignment: .bottomTrailing) {
                            PhotosPicker(
                                selection: $createViewModel.imageSelection,
                                matching: .images,
                                photoLibrary: .shared()) {
                                    Image(systemName: "pencil.circle.fill")
                                        .symbolRenderingMode(.multicolor)
                                        .font(.system(size: 35))
                                        .foregroundColor(.yellow)
                            }
                            .buttonStyle(.borderless) // make hit box on icon
                        }
                        .frame(maxWidth: .infinity)
                }

                Section(header: Text("Keyboard Specs")) {
                    Picker("Size", selection: $createViewModel.post.keyboard.size) {
                        Text("100% (Full Sized)").tag(KeyboardSize.full_sized)
                        Text("96% (Compact Full Sized)").tag(KeyboardSize.compact_full_sized)
                        Text("80% (Tenkeyless)").tag(KeyboardSize.tenkeyless)
                        Text("75% (Compact Tenkeyless)").tag(KeyboardSize.compact_tenkeyless)
                        Text("65% (Compact)").tag(KeyboardSize.compact)
                        Text("60% (Mini)").tag(KeyboardSize.mini)
                    }
                    
                    CreateTextField(title: "Keycaps", placeholder: "Keycap name", text: $createViewModel.post.keyboard.keycaps)
                    
                    CreateTextField(title: "Switches", placeholder: "Switch name", text: $createViewModel.post.keyboard.switches)
                    
                    CreateTextField(title: "Case", placeholder: "Case name", text: $createViewModel.post.keyboard.case)
                    
                    CreateTextField(title: "Plate", placeholder: "Plate name", text: $createViewModel.post.keyboard.plate)
                    
                    CreateTextField(title: "Foam", placeholder: "Foam name", text: $createViewModel.post.keyboard.foam)

                    Button("create", action: { Task { await handleCreateButton() } })
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 4)
                        .frame(maxWidth: .infinity) // match parent
                    
//                        .border(.orange)
                }
            }
            .navigationTitle("post a keyboard ")
        }
    }
    
    private func handleCreateButton() async {
        homeViewModel.posts.insert(self.createViewModel.post, at: 0) // add post locally
        await createViewModel.createPost()
    }
    
    
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
            .environmentObject(CreateViewModel())
            .environmentObject(HomeViewModel())
        
        KeyboardImage(imageState: .empty)
    }
}

struct CreateTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width: 151, alignment: .leading)
            
            TextField(placeholder, text: $text)
                .createTextFieldStyle()
        }
    }
}

// Custom modifier
struct CreateTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
//            .multilineTextAlignment(.trailing)
            .foregroundColor(.secondary)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
    }
}

extension View {
    func createTextFieldStyle() -> some View {
        modifier(CreateTextFieldStyle())
    }
}


struct KeyboardImage: View {
    let imageState: CreateViewModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let data):
            Image(uiImage: UIImage(data: data)!)
                .resizable().scaledToFit()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "keyboard")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .padding()
                .foregroundColor(.secondary)
//                .border(.orange)
            
        case .failure(let error):
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}
