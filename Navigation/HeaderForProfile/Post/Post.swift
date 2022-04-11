//
//  Post.swift
//  Navigation
//
//  Created by Александр Якубов on 12.04.2022.
//

import UIKit

struct Post {
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
    var isLiked: Bool
}

var post1 = Post(author: "Zendaya", description: "Hello", image: "first", likes: 104, views: 330, isLiked: false)
var post2 = Post(author: "Zendaya", description: "!!!", image: "second", likes: 111, views: 211, isLiked: false)
var post3 = Post(author: "Zendaya", description: "GM!", image: "third", likes: 124, views: 224, isLiked: false)
var post4 = Post(author: "Zendaya", description: "Love", image: "forth", likes: 134, views: 234, isLiked: false)
var post5 = Post(author: "Zendaya", description:"!@!", image: "19", likes: 1444, views: 2444, isLiked: false)

var posts = [post1, post2, post3, post4, post5]

