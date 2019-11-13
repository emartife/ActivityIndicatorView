//
//  Copyright © 2019 Enrique Martínez Fernández. All rights reserved.
//

import SwiftUI
import UIKit

public struct ActivityIndicator: UIViewRepresentable {

    public typealias UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style

    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    public func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

@available(iOS 13.0, *)
public struct ActivityIndicatorView<Content>: View where Content: View {
    private var isShowing: Binding<Bool>
    private var content: () -> Content

    public init(isShowing: Binding<Bool>, content: @escaping () -> Content) {
        self.isShowing = isShowing
        self.content = content
    }

    public var body: some View {
        ZStack(alignment: .center) {
            if (!self.isShowing.wrappedValue) {
                self.content()
            } else {
                self.content()
                    .disabled(true)
                    .blur(radius: 3)

                VStack {
                    ActivityIndicator(style: .large)
                }
                .frame(width: 100.0, height: 100.0)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
            }
        }
    }
}
