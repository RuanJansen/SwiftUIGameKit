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
    // Controller
    @State private var controllerType: ControllerType = .joystick(position: .onTouch)
    @State private var controllerPosition: CGPoint = CGPoint(x: 200, y: 500)
    @State private var isActive: Bool = false
    @State private var sensitivity: Float = 1
    @State private var currentAngle: Double = 0.0

    // Ball
    @State private var position: CGPoint = CGPoint(x: 200, y: 200)
    @State private var presentSettings: Bool = false
    @State private var viewFrame: CGRect = CGRect()
    @State private var isShowingBall: Bool = true

    // Input Text
    @State private var isShowingInputText: Bool = true

    var body: some View {
        GameView {
            GeometryReader { proxy in
                ZStack {
                    if isShowingInputText {
                        VStack {
                            Text(String(describing: self.currentAngle))
                            Spacer()
                                .position(position)
                        }
                    }
                    if isShowingBall {
                        Circle()
                            .fill(.cyan)
                            .frame(width: 50)
                            .position(position)
                    }
                }
            }
        }
        .controlable(controllerType: controllerType) { angle, isActive in
            self.isActive = isActive
            self.currentAngle = angle
            switch controllerType {
            case .joystick(_):
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                    if self.isActive {
                        updatePosition(with: self.currentAngle, by: self.sensitivity)
                    } else {
                        timer.invalidate()
                        self.currentAngle = 0
                    }
                }
            case .drag:
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                    if self.isActive {
                        updatePosition(with: angle, by: self.sensitivity)
                    } else {
                        timer.invalidate()
                        self.currentAngle = 0
                    }
                }
            case .arrows(_):
                updatePosition(with: angle, by: self.sensitivity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    presentSettings.toggle()
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(isPresented: $presentSettings) {
            SettingsView(position: $position, controllerPosition: $controllerPosition, controllerType: $controllerType, sensitivity: $sensitivity, isActive: $isActive, isShowingInputText: $isShowingInputText, isShowingBall: $isShowingBall).presentationDetents([.medium, .large])
        }
    }

    private func updatePosition(with angle: Double, by sensitivity: Float) {
        let angleInRadians: Float = Float(angle * .pi / 180.0)

        let deltaX = cos(angleInRadians) * sensitivity
        let deltaY = sin(angleInRadians) * sensitivity

        self.position.x += CGFloat(deltaX)
        self.position.y += CGFloat(deltaY)
    }
}

#Preview {
    DashboardView()
}
