//
//  ContentView.swift
//  Cocoaheads2
//
//  Created by Christian Menschel on 22.09.20.
//

import SwiftUI

struct ContentView: View {
    let url: URL
    let staticCache = StaticImageCache()
    @Environment(\.imageCache) var imageCache: ImageCache

    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: ViewModifierView(),
                    label: {
                        Text("ViewModifierView")
                    })
                NavigationLink(
                    // Here you can append the environment to use a custom locale
                    destination: Environments(), //.environment(\.locale, Locale(identifier: "DE")),
                    label: {
                        Text("Locale Environment")
                    })
                NavigationLink(
                    // Here you can append the environment to use a cache (i.e. for testing)
                    destination: ImageView(url: url), //.environment(\.imageCache, staticCache),
                    label: {
                        Text("Image with cache (custom Environment)")
                    })
                NavigationLink(
                    destination: KeyboardView(),
                    label: {
                        Text("Keyboard handling")
                    })
                NavigationLink(
                    destination: NavigatableImageView(url: url),
                    label: {
                        Text("Wrong and correct UIViewRepresentable handling")
                    })
                NavigationLink(
                    destination: StateObjectDemo(),
                    label: {
                        Text("StateObjectDemo")
                    })
            }.navigationTitle("SwiftUI Tips")
        }
    }
}
