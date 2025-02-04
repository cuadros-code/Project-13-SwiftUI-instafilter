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
    
    var body: some View {
        VStack {
            
            PhotosPicker(
                "Select a picture",
                selection: $pickerImage,
                matching: .images
            )
            
            selectedImage?
                .resizable()
                .scaledToFit()
        }
        .onChange(of: pickerImage) {
            Task {
                selectedImage = try await pickerImage?.loadTransferable(type: Image.self)
            }
        }
    }
}

#Preview {
    LoadPhotosUser()
}
