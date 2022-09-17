//
//  PostItem.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/17/22.
//

import SwiftUI

struct PostItem: View {
    @Binding var post: Post
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Text("u/timmypass17")
                    Text("2h")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                    }
                }
                .font(.footnote)
                
                
                Text(post.title)
                    .font(.body)
                    .bold()
            }
            .padding()
            
            Rectangle()
                .fill(.regularMaterial)
                .frame(height: 300)
            
            HStack {
                Button(action: {}) {
                    Label("26.0k", systemImage: "heart")
                }

                
                Spacer()
                
                Button(action: {}) {
                    Label("165", systemImage: "message")
                }
                
                Spacer()
                
                Button(action: {}) {
                    Label("3159", systemImage: "message")
                }
                
                Spacer()
                
                Button(action: {}) {
                    Label("Share", systemImage: "arrowshape.turn.up.right")
                }
            }
            .padding()
            .font(.footnote)
        }
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(post: .constant(Post.samplePosts[0]))
            .previewLayout(.sizeThatFits)
    }
}
