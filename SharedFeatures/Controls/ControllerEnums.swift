//
//  ControllerEnums.swift
//  SwiftUIGameKit
//
//  Created by Ruan Jansen on 2024/04/29.
//

import Foundation

public enum ControllerType {
    case joystick(position: ControllerPosition)
    case drag
    case arrows(position: CGPoint)
}

public enum ControllerPosition {
    case onTouch
    case fixed(position: CGPoint)
}
