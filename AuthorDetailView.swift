//
//  AuthorDetailView.swift
//  bookRecord
//
//  Created by  on 12/03/2026.
//

import SwiftUI
import SwiftData

struct AuthorDetailView: View {
    @Bindable var author: Author // @Bindable allows direct editing of model properties
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Form {
            Section("Basic Info") {
            TextField("Name", text: $author.name)
            }
            Section("Biography") {
                TextEditor(text: $author.biography)
                    .frame(minHeight: 150)
            }
            Section("Books by this Author") {
                if let books = author.books, !books.isEmpty {
                    ForEach(books) { book in
                        Text(book.name)
                    }
                } else {
                    Text("No books linked yet.")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Edit Author")
        .navigationBarTitleDisplayMode(.inline)
    }
}
