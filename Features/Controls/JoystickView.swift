//
//  JoystickView.swift
//  SwiftUIGameKit
//
//  Created by Ruan Jansen on 2024/04/29.
//

import Foundation
import SwiftUI

struct JoystickView: View {
    @State private var location: CGPoint = CGPoint(x: 200, y: 500)
    @State private var innerCircleLocation: CGPoint = CGPoint(x: 200, y: 500)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil

    private let bigCircleRadius: CGFloat = 100
    private let input: (Double)-> Void
    private var velocity: CGPoint = .zero

    init(input: @escaping (Double)-> Void) {
        self.input = input
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
                input(calcAngle())
            }
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
            .onEnded { value in
                let center = location
                innerCircleLocation = center
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

            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 50, height: 50)
                .position(innerCircleLocation)
                .gesture(fingerDrag)
        }
    }
}
