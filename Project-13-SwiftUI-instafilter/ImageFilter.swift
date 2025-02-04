//
//  ImageFilter.swift
//  Project-13-SwiftUI-instafilter
//
//  Created by Kevin Cuadros on 4/02/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ImageFilter: View {
    @State private var image: Image?
    @State private var sliderAmount = 1.0
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        Slider(value: $sliderAmount, in: -10...1)
        
            .onAppear(perform: loadImage)
            .onChange(of: sliderAmount) {
                loadImage()
            }
    }
    
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let contexts = CIContext()
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        
        let amount = sliderAmount
        let inputKeys = currentFilter.inputKeys
        
        //        currentFilter.intensity = -5
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = contexts.createCGImage(outputImage, from: outputImage.extent)else {
            return
        }
        let iuImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: iuImage)
    }
}

#Preview {
    ImageFilter()
}
