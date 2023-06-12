//
//  Movie.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import Foundation
//MARK: struct for a contact...
struct Movie{
    var title:String
    var description:String
    var image: String
    var author: String
    
    init (title: String, description: String, image: String, author: String) {
        self.title = title
        self.description = description
        self.image = image
        self.author = author
    }
}

import Foundation
