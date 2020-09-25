
import SwiftUI
import Combine

struct KeyboardResponsiveModifier: ViewModifier {
    static var subscriptions = [AnyCancellable]()
    @State private var offset: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .offset(x: 0, y: -self.offset)
            .onAppear {
                Self.subscriptions.removeAll()
                NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
                    .sink { note in
                        guard let value = note.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                            return
                        }
                        let height = value.height
                        let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
                        withAnimation {
                            self.offset = (height - (bottomInset ?? 0))
                        }
                }.store(in: &Self.subscriptions)
                NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                    .sink { _ in
                        withAnimation {
                            self.offset = 0
                        }
                }.store(in: &Self.subscriptions)
        }
    }
}

extension View {
    func keyboardHandling() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
        modifier(KeyboardResponsiveModifier())
    }
}










extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
