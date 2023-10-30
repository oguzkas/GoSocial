//
//  PostModel.swift
//  GoSocialV2
//
//  Created by Oğuz  on 28.10.2023.
//

import Foundation

struct Post: Identifiable, Decodable, Equatable{
    var id: String
    var title: String
    var posts: String
}

