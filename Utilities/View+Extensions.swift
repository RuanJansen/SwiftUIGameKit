//
//  View+Extensions.swift
//  Pods-SwiftUIGameKit_Example
//
//  Created by Ruan Jansen on 2024/04/29.
//

import SwiftUI

public extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
