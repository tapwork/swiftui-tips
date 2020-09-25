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
            VStack(alignment: .leading, spacing: 20) {
                NavigationLink(
                    destination: ViewModifierView(),
                    label: {
                        Text("ViewModifierView").paddingBackground(color: .gray)
                    })
                NavigationLink(
                    destination: Environments(), //.environment(\.locale, Locale(identifier: "DE")),
                    label: {
                        Text("Locale Environment").paddingBackground(color: .gray)
                    })
                NavigationLink(
                    destination: ImageView(url: url), //.environment(\.imageCache, staticCache),
                    label: {
                        Text("Image with cache (custom Environment)").paddingBackground(color: .gray)
                    })
                NavigationLink(
                    destination: KeyboardView(),
                    label: {
                        Text("Keyboard handling").paddingBackground(color: .gray)
                    })
                NavigationLink(
                    destination: NavigatableImageView(url: url),
                    label: {
                        Text("Wrong and correct UIViewRepresentable handling").paddingBackground(color: .gray)
                    })
                NavigationLink(
                    destination: StateObjectDemo(),
                    label: {
                        Text("StateObjectDemo").paddingBackground(color: .gray)
                    })
            }
        }
    }
}
