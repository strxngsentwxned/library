//
//  bookRecordApp.swift
//  bookRecord
//
//  Created by  on 12/03/2026.
//

import SwiftUI
import Foundation
import SwiftData

@main
struct bookRecordApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Author.self, Book.self])
    }
}
