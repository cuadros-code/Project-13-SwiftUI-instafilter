//
//  ContentView.swift
//  Project-13-SwiftUI-instafilter
//
//  Created by Kevin Cuadros on 29/01/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let contexts = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 0
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = contexts.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }
        let iuImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: iuImage)
    }
}

#Preview {
    ContentView()
}
