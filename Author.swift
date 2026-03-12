//
//  Author.swift
//  bookRecord
//
//  Created by  on 12/03/2026.
//


import Foundation
import SwiftData
@Model
class Author {
    @Attribute(originalName: "name") var fullTitle: String
    var name: String
    var biography: String
    // 級聯刪除：刪除作者時，其關聯的所有書本也會⼀併刪除
    @Relationship(deleteRule: .deny, inverse: \Book.author)
    var books: [Book]? = []
    init(name: String = "", biography: String = "", fullTitle: String = "") {
        self.name = name
        self.biography = biography
        self.fullTitle = fullTitle
    }
}
