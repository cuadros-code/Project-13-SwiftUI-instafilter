//
//  ContentView.swift
//  Project-13-SwiftUI-instafilter
//
//  Created by Kevin Cuadros on 29/01/25.
//

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

#Preview {
    ContentView()
}
