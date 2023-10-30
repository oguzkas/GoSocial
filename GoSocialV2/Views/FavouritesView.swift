//
//  FavouritesView.swift
//  GoSocialV2
//
//  Created by Oğuz  on 28.10.2023.
//

import SwiftUI

struct FavouritesView: View {
    @Binding var likedPosts: [Post]
    var body: some View {
        List(likedPosts) { item in
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(item.posts)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                HStack{
                    Spacer()
                    Button {
                        if let index = likedPosts.firstIndex(where: {$0.id == item.id }) {
                            likedPosts.remove(at: index)
                        } else{
                            likedPosts.append(item)
                        }
                    } label: {
                        Image(systemName: likedPosts.contains(item) ? "heart.fill" : "heart")
                            .foregroundStyle(likedPosts.contains(item) ? .red: .primary)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }

        }
        .navigationTitle("Favourites")
    }
}

