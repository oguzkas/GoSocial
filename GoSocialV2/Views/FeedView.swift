//
//  FeedView.swift
//  GoSocialV2
//
//  Created by Oğuz  on 28.10.2023.
//

import SwiftUI
import FirebaseAuth

struct FeedView: View {
    @AppStorage("uid") var userID: String = ""
    @ObservedObject var dataClass = PostModel()
    @State var title = ""
    @State var posts = ""
    @State var likedPosts: [Post] = []
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea(.all)
            
            TabView {
                NavigationView {
                    List(dataClass.postList){item in
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
                    .onAppear{
                        dataClass.fetchPost()
                    }
                    .navigationTitle("GoSocial")
                    .navigationBarItems(
                        trailing: HStack{
                            Button(action: {
                                do{
                                    try Auth.auth().signOut()
                                    userID = ""
                                }catch{
                                    print("Sign Out Hatası")
                                }
                            }, label: {
                                Image(systemName: "escape")
                                    .foregroundStyle(.red)
                            })
                                Image("avatar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 60)
                                .clipShape(Circle())
                        })
                    
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                NavigationView{
                    FavouritesView(likedPosts: $likedPosts)
                }
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
                NavigationView{
                    ZStack {
                        VStack {
                            VStack(spacing: 5){
                                HStack {
                                    TextField("Title", text: $title)
                                        .textFieldStyle(.roundedBorder)
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(lineWidth: 2)
                                        .foregroundStyle(.gray)
                                )
                                HStack{
                                    TextField("Body", text: $posts)
                                        .textFieldStyle(.roundedBorder)
                                }
                                .overlay(
                                RoundedRectangle(cornerRadius:20)
                                    .stroke(lineWidth: 2)
                                    .foregroundStyle(.gray)
                                )
                                Button(action: {
                                    dataClass.addPost(title: title, posts: posts)
                                    title = ""
                                    posts = ""
                                }, label: {
                                    Text("Add New Post")
                                        .foregroundStyle(.white).opacity(0.8)
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.black)
                                        )
                                        .padding(.horizontal)
                                })
                            }
                            .padding()
                        }
                    }
                    
                    
                }
                .tabItem {
                    Label("Add New Post", systemImage: "pencil")
                }
            }
        }
    }
}


#Preview {
    FeedView()
}
