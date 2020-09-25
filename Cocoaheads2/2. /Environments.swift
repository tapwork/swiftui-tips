//
//  CustomEnvironments.swift
//  Cocoaheads2
//
//  Created by Christian Menschel on 24.09.20.
//

import SwiftUI

struct Environments: View {
    @Environment(\.locale) var locale: Locale

    var body: some View {
        Text("Your are \(locale.localizedString(forIdentifier: locale.identifier) ?? "")")
    }
}
