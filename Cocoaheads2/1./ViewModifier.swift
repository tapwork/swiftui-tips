//
//  ContentView.swift
//  CocoaHeads
//
//  Created by Christian Menschel on 22.09.20.
//

import SwiftUI

struct ViewModifierView: View {
    var lang = "pl"
    var body: some View {
        Text("Title")
            .padding(60)
            .languageHeadline(lang: lang)
    }
}


extension View {
    func languageHeadline(lang: String) -> some View {
        modifier(LanguageHeadlineModifier(lang: lang))
    }
}

struct LanguageHeadlineModifier: ViewModifier {
    let lang: String

    func body(content: Content) -> some View {
        color(lang: lang, content: content)
            .font(.headline)
            .foregroundColor(Color.white)
    }

    func color(lang: String, content: Content) -> some View {
        switch lang {
        case "nl":
            return content.background(Color.orange)
        case "de":
            return content.background(Color.gray)
        case "pl":
            return content.background(Color.green)
        default:
            return content.background(Color.black)
        }
    }
}

struct ViewModifierView_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierView()
    }
}
