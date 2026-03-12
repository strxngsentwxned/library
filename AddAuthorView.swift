//
//  AddAuthorView.swift
//  bookRecord
//
//  Created by  on 12/03/2026.
//

import SwiftUI
import Foundation
import SwiftData

struct AddAuthorView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var bio = ""
    var body: some View {
        NavigationView {
            Form {
                TextField("Author Name", text: $name)
                TextField("Biography", text: $bio, axis: .vertical)
                    .lineLimit(5...10)
            }
                .navigationTitle("New Author")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let newAuthor = Author(name: name, biography: bio)
                            modelContext.insert(newAuthor)
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                }
        }
    }
}
