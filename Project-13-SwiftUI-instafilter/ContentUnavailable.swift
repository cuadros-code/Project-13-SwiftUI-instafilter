//
//  ContentUnavailable.swift
//  Project-13-SwiftUI-instafilter
//
//  Created by Kevin Cuadros on 3/02/25.
//

import SwiftUI

struct ContentUnavailable: View {
    var body: some View {
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet.")
        } actions: {
            Button("Create snippet") {
                
            }
        }
    }
}

#Preview {
    ContentUnavailable()
}
