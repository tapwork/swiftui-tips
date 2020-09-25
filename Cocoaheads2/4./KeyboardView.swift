//
//  ContentView.swift
//  CocoaHeads
//
//  Created by Christian Menschel on 22.09.20.
//

import SwiftUI

struct KeyboardView: View {
    @State var text: String = ""
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Welcome")
                Spacer(minLength: 300)
                TextField("Your Email", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, height: 50, alignment: .center)
                Button("Login", action: {})
                    .frame(width: 200, height: 60)
                Spacer(minLength: 80)
            }.keyboardHandling()
        }.simultaneousGesture(DragGesture().onChanged({ (_) in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }))
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
