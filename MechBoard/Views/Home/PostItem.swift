//
//  PostItem.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/17/22.
//

import SwiftUI

struct PostItem: View {
    @Binding var post: Post
    var onClickOption: (Post) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Text("u/timmypass17")
                    Text(post.timeCreatedFormatted())
                    Spacer()
                    Button(action: { onClickOption(post) }) {
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
                    Label("Share", systemImage: "arrowshape.turn.up.right")
                }
            }
            .padding()
            .font(.footnote)
        }
    }
    
}

//struct PostItem_Previews: PreviewProvider {
//    static var previews: some View {
//        PostItem(post: .constant(Post.samplePosts[0]))
//            .previewLayout(.sizeThatFits)
//    }
//}
