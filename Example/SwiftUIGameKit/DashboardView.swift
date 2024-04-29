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
        .controlable(controllerType: .joystick) { angle in
            updatePosition(with: angle)
        }
    }

    private func updatePosition(with angle: Double) {
        let angleInRadians = angle * .pi / 180.0

        let deltaX = cos(angleInRadians) * 2.5
        let deltaY = sin(angleInRadians) * 2.5

        position.x += CGFloat(deltaX)
        position.y += CGFloat(deltaY)
    }
}

#Preview {
    DashboardView()
}
