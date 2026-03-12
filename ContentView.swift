//
//  ContentView.swift
//  bookRecord
//
//  Created by  on 12/03/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Book.name) private var books: [Book]
    @State private var isGridView = false
    
    let columns = [
    GridItem(.adaptive(minimum: 150)),
    ]
    
    var body: some View {
        NavigationView {
            Group {
                if books.isEmpty {
                    ContentUnavailableView {
                        Label("No Books", systemImage: "book.closed" )
                    } description: {
                        Text("Add your first book to get started.")
                    }
                } else if isGridView {
                        bookGrid
                    } else {
                        bookList
                    }
                }
                    .navigationTitle("My Library")
                    .toolbar {
                        // 3. The Toggle Switch in the Toolbar
                        ToolbarItem(placement: .topBarTrailing, content: {
                            NavigationLink {
                                BookDetailView()
                            } label: {
                                Image(systemName: "plus")
                            }
                        })
                        ToolbarItem(placement: .topBarTrailing, content: {
                            NavigationLink {
                                AuthorListView()
                            } label: {
                                Image(systemName: "person")
                            }
                        })
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                isGridView.toggle()
                            }) {
                                Image(systemName: isGridView ? "list.bullet" : "square.grid.3x3")
                            }
                        }
                    }
            }
        }
        private var bookGrid: some View {
            ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                    VStack {
                        coverImage(for: book, size: 100)
                        Text(book.name)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundStyle(.primary)
                        }
                    }
                }
            }
                .padding()
            }
        }
        
    private var bookList: some View {
        List {
        ForEach(books) { book in
            NavigationLink(destination: BookDetailView(book: book)) {
                HStack(spacing: 15) {
                    //coverImage(for: book, size: 50)
                    VStack(alignment: .leading) {
                        Text(book.name).font(.headline)
                        Text(book.author?.name ?? "Unknown").font(.subheadline).foregroundStyle(.secondary)
                    }
                }
            }
        }
//            .onDelete(perform: deleteBooks)
        }
    }
    
    @ViewBuilder
    func coverImage(for book: Book, size: CGFloat) -> some View {
        if let data = book.photo, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size * 1.4) // Standard book ratio
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
        // Placeholder if no photo exists
            ZStack {
                Color.gray.opacity(0.3)
                Image(systemName: "book")
                    .foregroundStyle(.secondary)
            }
                .frame(width: size, height: size * 1.4)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    ContentView()
}
