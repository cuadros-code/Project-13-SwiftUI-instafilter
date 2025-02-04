//
//  SharedLinkView.swift
//  Project-13-SwiftUI-instafilter
//
//  Created by Kevin Cuadros on 4/02/25.
//

import SwiftUI

struct SharedLinkView: View {
    
    
    
    var body: some View {
        let example = Image(.example)
        
        ShareLink(
            item: URL(string: "https://www.hackingwithswift.com")!,
            subject: Text("Learn Swift here"),
            message: Text("Check out the 100 days of SwiftUi")
        )
        
        ShareLink(
            item: URL(string: "https://www.hackingwithswift.com")!
        ) {
            Label("Spread the word about SwiftUI", systemImage: "swift")
        }
        
        ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
            Label("Click to share", systemImage: "airplane")
        }
    }
}

#Preview {
    SharedLinkView()
}
