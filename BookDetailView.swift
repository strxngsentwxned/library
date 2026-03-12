//
//  BookDetailView.swift
//  bookRecord
//
//  Created by  on 12/03/2026.
//

import SwiftUI
import PhotosUI
import SwiftData

struct BookDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @Query var authors: [Author] // Fetch existing authors to pick from
    var book : Book?
    // Form State
    @State private var name = ""
    @State private var isbn = ""
    @State private var description = ""
    @State private var selectedAuthor: Author?
    
    var body: some View {
        NavigationView {
            Form {
                // SECTION 1: The Book Cover
                Section("Book Cover") {
                    ZStack {
                        PhotosPicker("", selection: $selectedItem, matching: .images)
                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                            // Show the actual picked image
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 200)
                                .frame(maxWidth: .infinity)
                        } else {
                            // Placeholder button
                            ContentUnavailableView {
                                Label("Add Photo", systemImage: "photo.badge.plus")
                            } description: {
                                Text("Tap to select a book cover from your library")
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets()) // Makes the image fill the section width
                    .onChange(of: selectedItem) { _ in
                        loadPhoto()
                    }
                }
                // SECTION 2: Text Details
                Section("Details") {
                    TextField("Book Name", text: $name)
                    TextField("ISBN", text: $isbn)
                    TextField("Description", text: $description)
                }
                Section {
                    Picker("Select Author", selection: $selectedAuthor) {
                        Text("Unknown").tag(nil as Author?)
                        ForEach(authors) { author in
                            Text(author.name).tag(author as Author?)
                        }
                    }
                }
            }
            Button("Save Book") {
                saveBook()
            }
            .disabled(name.isEmpty) // Prevent saving without a title
            .navigationTitle("New Book")
        }
        .onChange(of: selectedItem) { _ in
            loadPhoto()
        }
        .onAppear(){
            if let book {
                self.name = book.name
                self.isbn = book.isbn
                self.description = book.bookDescription
                self.selectedImageData = book.photo
                self.selectedAuthor = book.author
            }
        }
    }
    
    func saveBook() {
        // Here you would find/create the Author object first (as we discussed)
        if let book {
            book.name = name
            book.isbn = isbn
            book.bookDescription = description
            //book.photo = selectedImageData
            book.author = selectedAuthor
        }else{
            let newBook = Book(
                name: name,
                isbn: isbn,
                bookDescription: description
                //photo: selectedImageData
            )
            newBook.author = selectedAuthor // This creates the relationship
            modelContext.insert(newBook)
        }
        dismiss() // Pop back to the list
    }
    
    func loadPhoto() {
        Task {
            if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
            // Switch back to the main thread to update the UI
                await MainActor.run {
                    self.selectedImageData = data
                }
            }
        }
    }
}

#Preview {
    BookDetailView()
        .modelContainer(for: [Book.self, Author.self])
}
