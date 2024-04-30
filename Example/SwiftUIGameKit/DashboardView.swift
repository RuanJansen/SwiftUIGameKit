//
//  DashboardView.swift
//  SwiftUIGameKit_Example
//
//  Created by Ruan Jansen on 2024/04/29.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import SwiftUIGameKit

struct DashboardView: View {
    @State private var position: CGPoint = .zero
    @State private var controllerPosition: CGPoint = CGPoint(x: 200, y: 500)
    @State private var controllerType: ControllerType = .drag
    @State private var isActive: Bool = false

    var body: some View {
        GameView {
            GeometryReader { proxy in
                Circle()
                    .fill(.pink)
                    .frame(width: 50)
                    .position(position)
                    .onAppear {
                        let x = proxy.size.width/2
                        let y = proxy.size.height/3
                        position = CGPoint(x: x, y: y)
                    }
            }
        }
        .controlable(controllerType: controllerType) { angle, isActive in
            self.isActive = isActive
            switch controllerType {
                case .joystick(_):
                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                        if !self.isActive {
                            timer.invalidate()
                        } else {
                            updatePosition(with: angle, by: 0.5)
                        }
                    }
                case .drag:
                    updatePosition(with: angle, by: 5)
                case .arrows(_):
                updatePosition(with: angle, by: 5)
                }


        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func updatePosition(with angle: Double, by value: Double) {
        let angleInRadians = angle * .pi / 180.0

        let deltaX = cos(angleInRadians) * value
        let deltaY = sin(angleInRadians) * value

        position.x += CGFloat(deltaX)
        position.y += CGFloat(deltaY)
    }
}

#Preview {
    DashboardView()
}
