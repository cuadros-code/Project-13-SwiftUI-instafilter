//
//  LoadPhotosUser.swift
//  Project-13-SwiftUI-instafilter
//
//  Created by Kevin Cuadros on 4/02/25.
//

import SwiftUI
import PhotosUI

struct LoadPhotosUser: View {
    
    @State private var pickerImage: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    @State private var pickerImagesList = [PhotosPickerItem]()
    @State private var selectedImagesList = [Image]()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                List {
                    Section("One Item") {
                        selectedImage?
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Section("Many Items") {
                        ForEach(0..<selectedImagesList.count, id: \.self) { i in
                            selectedImagesList[i]
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    PhotosPicker(
                        "Select a picture",
                        selection: $pickerImage,
                        matching: .images
                    )
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(
                        "Select a picture list",
                        selection: $pickerImagesList,
                        maxSelectionCount: 3,
                        matching: .images
                    )
                }
            }
            .onChange(of: pickerImage) {
                Task {
                    selectedImage = try await pickerImage?.loadTransferable(type: Image.self)
                }
            }
            .onChange(of: pickerImagesList) {
                selectedImagesList.removeAll()
                Task {
                    for item in pickerImagesList {
                        if let image = try await item.loadTransferable(type: Image.self) {
                            selectedImagesList.append(image)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LoadPhotosUser()
}
