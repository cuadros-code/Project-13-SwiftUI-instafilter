//
//  AppStoreReviewView.swift
//  Project-13-SwiftUI-instafilter
//
//  Created by Kevin Cuadros on 4/02/25.
//

import SwiftUI
import StoreKit

struct AppStoreReviewView: View {
    
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        VStack {
            Button("Leave a review") {
                requestReview()
            }
        }
    }
}

#Preview {
    AppStoreReviewView()
}
