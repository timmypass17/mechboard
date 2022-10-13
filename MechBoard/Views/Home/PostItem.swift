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
            HStack {
                Circle()
                    .fill(.regularMaterial)
                    .frame(width: 50)
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
            }
            .padding()
            
            Image("sample_post")
                .resizable()
                .scaledToFit() // or .aspectRatio(contentMode: .fit)
            
            if !post.caption.isEmpty {
                Caption(text: "\"\(post.caption)\"")
                    .lineLimit(2)
                    .italic()
            }
            
            HStack {
                Button(action: {}) {
                    Label("\(post.likes.count)", systemImage: "heart")
                }

                
                Spacer()
                
                Button(action: {}) {
                    Label("0", systemImage: "message")
                }
            
                Spacer()
                
                Button(action: {}) {
                    Label("Share", systemImage: "arrowshape.turn.up.right")
                }
            }
            .padding()
            .font(.footnote)
            
            Divider()
                .padding(.top, 1)
        }
    }
    
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(post: .constant(Post.samplePosts[0]), onClickOption: {_ in })
            .previewLayout(.sizeThatFits)
//            .border(.blue)
    }
}

struct Caption: View {
    let text: String
    var body: some View {
        HStack {
            Text(text)
                .font(.caption)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
        }
    }
}
