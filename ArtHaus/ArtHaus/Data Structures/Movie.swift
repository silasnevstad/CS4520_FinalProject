//
//  Movie.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import Foundation

class Movie {
    var title: String
    var description: String
    var image: String
    var author: String
    var authorUserId: String
    var documentId: String

    init(title: String, description: String, image: String, author: String, authorUserId: String, documentId: String) {
        self.title = title
        self.description = description
        self.image = image
        self.author = author
        self.authorUserId = authorUserId
        self.documentId = documentId
    }
}
