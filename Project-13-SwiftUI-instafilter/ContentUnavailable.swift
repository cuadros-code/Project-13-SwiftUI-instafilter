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
            Label("No Picture", systemImage: "photo.badge.plus")
        } description: {
            Text("Tap to import a photo")
        } actions: {
            Button("Create snippet") {
                
            }
        }
    }
}

#Preview {
    ContentUnavailable()
}
