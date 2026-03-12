//
//  AuthorListView.swift
//  bookRecord
//
//  Created by  on 12/03/2026.
//


import SwiftUI
import Foundation
import SwiftData

struct AuthorListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Author.name) private var authors: [Author]
    @State private var isAddingAuthor = false
    var body: some View {
        NavigationView {
            List {
                ForEach(authors) { author in
                    NavigationLink {
                        AuthorDetailView(author: author)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(author.name).font(.headline)
                            Text("\(author.books?.count ?? 0) Books").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
                    .onDelete(perform: deleteAuthors)
            }
            .navigationTitle("Authors")
            .toolbar {
                Button { isAddingAuthor = true } label: { Image(systemName: "plus") }
            }
            .sheet(isPresented: $isAddingAuthor) {
                AddAuthorView()
            }
        }
    }
    // delete
    
    func deleteAuthors(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(authors[index])
        }
    }
}
