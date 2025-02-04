//
//  ContentView.swift
//  Project-13-SwiftUI-instafilter
//
//  Created by Kevin Cuadros on 29/01/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImage = [Image]()
    
    var body: some View {
        VStack {
            PhotosPicker(
                "Select a picture",
                selection: $pickerItems,
                maxSelectionCount: 3,
                matching: .images
            )
            
            PhotosPicker(
                selection: $pickerItems,
                maxSelectionCount: 3,
                matching: .any(of: [.images, .not(.screenshots)])
            ) {
                Label("Select a picture", systemImage: "photo")
            }
            
            ScrollView {
                ForEach(0..<selectedImage.count, id: \.self) { image in
                    selectedImage[image]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems) {
            Task {
                
                selectedImage.removeAll()
                
                for item in pickerItems {
                    if let loadedImages = try await item.loadTransferable(
                        type: Image.self
                    ) {
                        selectedImage.append(loadedImages)
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
