//
//  Book.swift
//  bookRecord
//
//  Created by  on 12/03/2026.
//

import Foundation
import SwiftData

@Model
class Book {
    var name: String
    var isbn: String
    var bookDescription: String
    // 使⽤外部存儲來處理⼤型圖⽚，避免資料庫檔案過⼤
    @Attribute(.externalStorage) var photo: Data?
    var author: Author?
    init(name: String = "", isbn: String = "", bookDescription: String = "", photo: Data? = nil) {
        self.name = name
        self.isbn = isbn
        self.bookDescription = bookDescription
        self.photo = photo
    }
}
