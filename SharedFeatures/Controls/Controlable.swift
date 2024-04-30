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
                     controllerPosition: ControllerPosition,
                     input: @escaping (Double, Bool)-> Void) -> some View {
        self.overlay {
            switch controllerType {
            case .joystick:
                JoystickView(controllerposition: controllerPosition) { angle, isActive in
                    input(angle, isActive)
                }
            case .drag:
                DragView(controllerposition: controllerPosition) { angle in
//                    input(angle)
                }
            case .arrows:
                ArrowsView(controllerposition: controllerPosition) { direction in
//                    input(direction)
                }
            }
        }
    }
}
