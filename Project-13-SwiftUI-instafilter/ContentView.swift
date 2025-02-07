//
//  ContentView.swift
//  Project-13-SwiftUI-instafilter
//
//  Created by Kevin Cuadros on 29/01/25.
//

import PhotosUI
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit

struct ContentView: View {
    
    @Environment(\.requestReview) var requestReview
    @AppStorage("filterCount") var filterCount = 0
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilter = false
    
    // context is expensive to create, it's better to create it once
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else  {
                        ContentUnavailableView {
                            Label("No Picture", systemImage: "photo.badge.plus")
                        } description: {
                            Text("Tap to import a photo")
                        }
                    }
                }
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                }
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    Spacer()
                }
                
                .confirmationDialog(
                    "Select a filter",
                    isPresented: $showingFilter) {
                        Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                        Button("Edges") { setFilter(CIFilter.edges()) }
                        Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                        Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                        Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                        Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                        Button("Vignette") { setFilter(CIFilter.vignette()) }
                        Button("Cancel", role: .cancel) { }
                    }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if let processedImage {
                        ShareLink(
                            item: processedImage,
                            preview: SharePreview("Instafilter image", image: processedImage)
                        ) {
                            Label("", systemImage: "square.and.arrow.up")
                        }
                    }
                }
            }
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        filterCount += 1
        
        if filterCount >= 2 {
            requestReview()
        }
        
        currentFilter = filter
        loadImage()
    }
    
    func changeFilter() {
        showingFilter = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(
                type: Data.self
            ) else { return }
            
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(
            outputImage,
            from: outputImage
                .extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
}

#Preview {
    ContentView()
}
