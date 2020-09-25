//
//  UIViewRepresentable.swift
//  Cocoaheads2
//
//  Created by Christian Menschel on 24.09.20.
//

import SwiftUI
import Combine


struct ActivityView: UIViewRepresentable {
    // Wrong
//    var activity: UIActivityIndicatorView
//    init() {
//        activity = UIActivityIndicatorView()
//        activity.startAnimating()
//        print("Created \(Self.self)")
//    }

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        // Wrong
        // activity

        // Correct
        UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}

struct NavigatableImageView: View {
    @Environment(\.imageCache) var imageCache: ImageCache
    let url: URL
    @State var next = false
    @ObservedObject var loader = ImageLoader()

    var body: some View {
        VStack {
            NavigationLink(destination: NavigatableImageView(url: url), isActive: $next) { EmptyView() }
            Button("Next") { self.next = true }
//            if let image = loader.image(url: url, cache: imageCache) {
//                Image(uiImage: image).resizable()
//            } else {
//                ActivityView()
//            }
            ActivityView()
        }
    }
}
