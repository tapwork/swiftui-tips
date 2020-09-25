//
//  Cache.swift
//  Cocoaheads2
//
//  Created by Christian Menschel on 23.09.20.
//

import UIKit
import SwiftUI
import Combine


struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = MainImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}



struct ImageView: View {
    @Environment(\.imageCache) var imageCache: ImageCache
    let url: URL
    @ObservedObject var loader = ImageLoader()

    var body: some View {
        if let image = loader.image(url: url, cache: imageCache) {
            Image(uiImage: image)
        } else {
            ActivityView()
        }
    }
}


protocol ImageCache {
    func image(for url: URL) -> UIImage?
    func update(image: UIImage?, url: URL)
}

struct MainImageCache: ImageCache {
    static let cache = NSCache<NSURL, UIImage>()
    func image(for url: URL) -> UIImage? {
        Self.cache.object(forKey: url as NSURL)
    }
    func update(image: UIImage?, url: URL) {
        if image == nil {
            Self.cache.removeObject(forKey: url as NSURL)
        } else {
            Self.cache.setObject(image!, forKey: url as NSURL)
        }
    }
}

class ImageLoader: ObservableObject {
    var cache: ImageCache?
    var url: URL?
    var subscriptions = [AnyCancellable]()

    func image(url: URL, cache: ImageCache) -> UIImage? {
        self.cache = cache
        self.url = url
        if let image = cache.image(for: url) {
            return image
        } else {
            fetch(url: url)
        }
        return nil
    }

    private func fetch(url: URL) {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .compactMap(UIImage.init(data:))
            .receive(on: DispatchQueue.main)
            .sink { (_) in }
                receiveValue: { image in
                    self.cache?.update(image: image, url: url)
                    self.objectWillChange.send()
                }.store(in: &subscriptions)
    }
}

struct StaticImageCache: ImageCache {
    func update(image: UIImage?, url: URL) {}
    func image(for url: URL) -> UIImage? {
        UIImage(named: "static.jpg")
    }
}
