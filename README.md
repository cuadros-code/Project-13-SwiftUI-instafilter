#  InstaFilter

## Understanding how @State works

- @State no almacena el valor en la estructura View, sino en un almacenamiento externo gestionado por SwiftUI.
- Como View es inmutable, SwiftUI reconstruye la vista en cada actualización de estado, pero el estado persiste en su almacenamiento.
- didSet solo se ejecuta cuando se modifica una propiedad almacenada en la estructura, pero en el caso de @State, el cambio ocurre en su almacenamiento interno.
- Para reaccionar a los cambios de @State, debes usar .onChange(of:) en lugar de didSet.

```swift
import SwiftUI

struct ContentView: View {
    
    @State private var blurAmount = 0.0 {
        didSet {
            print("\(blurAmount)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello word!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
        .padding()
    }
}
```

## confirmationDialog

```swift
import SwiftUI

struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Button("Dialog") {
            showingConfirmation.toggle()
        }
        .frame(width: 300, height: 300)
        .background(backgroundColor)
        
        .confirmationDialog("Change background", isPresented: $showingConfirmation) {
            Button("Red") { backgroundColor = .red }
            Button("Green") { backgroundColor = .green }
            Button("Blue") { backgroundColor = .blue }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Select a new color")
        }
    }
}
```

## Set image Filter

```swift
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
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
    
     func loadImageFilter() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let contexts = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = -5

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = contexts.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }
        let iuImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: iuImage)
    }
    
}
```
