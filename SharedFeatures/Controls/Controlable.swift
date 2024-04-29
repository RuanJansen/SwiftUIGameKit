//
//  Controlable.swift
//  SwiftUIGameKit
//
//  Created by Ruan Jansen on 2024/04/29.
//

import Foundation
import SwiftUI

public protocol Controlable {
    associatedtype Content: View
    var content: () -> Content { get }
}

public extension View where Self: Controlable {
    func controlable(controllerType: ControllerType,
                     input: @escaping (Double)-> Void) -> some View {
        self.overlay {
            switch controllerType {
            case .joystick:
                JoystickView() { angle in
                    input(angle)
                }
            case .drag:
                DragView() { angle in
                    input(angle)
                }
            case .arrows:
                ArrowsView() { direction in
                    input(direction)
                }
            }
        }
    }
}
