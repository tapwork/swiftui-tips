//
//  StateObject.swift
//  Cocoaheads2
//
//  Created by Christian Menschel on 24.09.20.
//

import SwiftUI
import Combine

struct StateObjectDemo: View {
    @State private var items = ["Hello"]

    var body: some View {
        VStack(spacing: 20) {
            Counter()

            Button("Update List") {
                items.append("World")
            }

            List(items, id: \.self) { name in
                Text(name)
            }
        }
    }
}

struct Counter: View {
    @StateObject var dataSource = DataSource()
    //  @ObservedObject var dataSource = DataSource()

    init() {
        print("Created Counter")
    }

    var body: some View {
        VStack {
            Button("Increment counter") {
                dataSource.counter += 1
            }
            Text("Count is \(dataSource.counter)")
        }
    }
}


class DataSource: ObservableObject {
    @Published var counter = 0
}
