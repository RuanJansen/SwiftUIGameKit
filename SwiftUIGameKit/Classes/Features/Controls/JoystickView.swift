//
//  JoystickView.swift
//  SwiftUIGameKit
//
//  Created by Ruan Jansen on 2024/04/29.
//

import Foundation
import SwiftUI

struct JoystickView: View {
    private let controllerposition: ControllerPosition
    private let input: (Double, Bool)-> Void

    private let bigCircleRadius: CGFloat

    @State 
    private var location: CGPoint

    @State
    private var innerCircleLocation: CGPoint

    @GestureState 
    private var fingerLocation: CGPoint?

    @GestureState
    private var startLocation: CGPoint?

    init(controllerposition: ControllerPosition,
         input: @escaping (Double, Bool)-> Void) {
        self.controllerposition = controllerposition
        self.input = input

        self.bigCircleRadius = 100

        self.location = CGPoint(x: 200, y: 500)
        self.innerCircleLocation = CGPoint(x: 200, y: 500)
    }

    private var isActive: Bool {
        fingerLocation != nil
    }

    private var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height

                let distance = sqrt(pow(newLocation.x - location.x, 2) + pow(newLocation.y - location.y, 2))

                if distance > bigCircleRadius {
                    let angle = atan2(newLocation.y - location.y, newLocation.x - location.x)
                    newLocation.x = location.x + cos(angle) * bigCircleRadius
                    newLocation.y = location.y + sin(angle) * bigCircleRadius
                }

                self.location = newLocation
                self.innerCircleLocation = newLocation
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
    }

    private var fingerDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                let distance = sqrt(pow(value.location.x - location.x, 2) + pow(value.location.y - location.y, 2))

                let angle = atan2(value.location.y - location.y, value.location.x - location.x)

                let maxDistance = bigCircleRadius

                let clampedDistance = min(distance, maxDistance)

                let newX = location.x + cos(angle) * clampedDistance
                let newY = location.y + sin(angle) * clampedDistance

                innerCircleLocation = CGPoint(x: newX, y: newY)
                input(calcAngle(), isActive)
            }
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
            .onEnded { value in
                let center = location
                innerCircleLocation = center
                input(calcAngle(), isActive)
            }
    }

    private func calcAngle() -> Double {
        let angle = atan2(innerCircleLocation.y - location.y, innerCircleLocation.x - location.x)
        var degrees = Int(angle * 180 / .pi)

        if degrees < 0 {
            degrees += 360
        }

        return Double(degrees)
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(.ultraThickMaterial)
                .frame(width: bigCircleRadius * 2, height: bigCircleRadius * 2)
                .position(location)

            if positionOnTouch() {
                Rectangle()
                    .fill(.black.opacity(0.0001))
                    .onTapGesture { tappedPosition in
                        location = tappedPosition
                        innerCircleLocation = tappedPosition
                    }
            }

            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 50, height: 50)
                .position(innerCircleLocation)
                .gesture(fingerDrag)
        }
    }

    private func positionOnTouch() -> Bool {
        switch controllerposition {
        case .onTouch:
            return true
        case .fixed(let position):
            location = position
            innerCircleLocation = position
            return false
        }
    }
}
