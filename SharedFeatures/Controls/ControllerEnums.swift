//
//  ControllerEnums.swift
//  SwiftUIGameKit
//
//  Created by Ruan Jansen on 2024/04/29.
//

import Foundation
import SwiftUI

public enum ControllerType: CaseIterable, Equatable, Hashable {
    public static var allCases: [ControllerType] = [Self.arrows(position: .zero), Self.drag, Self.joystick(position: .onTouch)]

    public static func == (lhs: ControllerType, rhs: ControllerType) -> Bool {
        lhs.description == rhs.description
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }


    case joystick(position: ControllerPosition)
    case drag
    case arrows(position: CGPoint)

    public var description: String {
        switch self {
        case .joystick(_):
            return "joystick"
        case .drag:
            return "drag"
        case .arrows(_):
            return "arrows"
        }
    }
}

public enum ControllerPosition {
    case onTouch
    case fixed(position: CGPoint)
}
