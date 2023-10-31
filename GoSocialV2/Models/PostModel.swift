//
//  PostModel.swift
//  GoSocialV2
//
//  Created by Oğuz  on 28.10.2023.
//

import Foundation



// Equatable ekle decodable yanına
struct Post: Identifiable, Decodable, Equatable{
    
    var id: String
    var title: String
    var posts: String

}

struct Comment: Identifiable, Decodable, Equatable {
    var id: String
    var text: String
}


