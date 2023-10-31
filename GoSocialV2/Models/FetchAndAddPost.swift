//
//  FetchAndAddPost.swift
//  GoSocialV2
//
//  Created by Oğuz  on 28.10.2023.
//

import Foundation
import Firebase


class PostModel: ObservableObject{
    @Published var postList = [Post] ()
    
    func addPost(title: String,posts: String){
        let db = Firestore.firestore()
        db.collection("Post").addDocument(data: ["title": title, "posts": posts]) { error in
            if error == nil {
                self.fetchPost()
            }else{
                print("Add Post Error!!")
            }
        }
    }
    
    func fetchPost(){
        let db = Firestore.firestore()
        
        db.collection("Post").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.postList = snapshot.documents.map({ datas in
                            return Post(id: datas.documentID, title: datas["title"] as? String ?? "", posts: datas["posts"] as? String ?? "")
                        })
                    }
                }
            }else {
                print("Error")
            }
        }
    }
    
    func addComment(to postID: String, text: String) {
        let db = Firestore.firestore()
        let commentRef = db.collection("Post").document(postID).collection("comments")
        commentRef.addDocument(data: ["text": text]) { error in
            if error != nil {
                print("Add Comment Error!!")
            }
        }
    }
    
    
    func fetchComments(for postID: String, completion: @escaping ([Comment]) -> Void) {
        let db = Firestore.firestore()
        let commentRef = db.collection("Post").document(postID).collection("comments")
        
        commentRef.getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    let comments = snapshot.documents.map { datas in
                        return Comment(id: datas.documentID, text: datas["text"] as? String ?? "")
                    }
                    completion(comments)
                }
            } else {
                print("Fetch Comments Error!!")
            }
        }
        
    }
}
