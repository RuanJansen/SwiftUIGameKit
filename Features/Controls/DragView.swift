//
//  DragView.swift
//  SwiftUIGameKit
//
//  Created by Ruan Jansen on 2024/04/29.
//

import Foundation
import SwiftUI

struct DragView: View {
    private let input:(Double)-> Void
    private var position: CGPoint
    private let controllerposition: ControllerPosition

    init(controllerposition: ControllerPosition,
         input: @escaping (Double)-> Void) {
        self.position = CGPoint()
        self.controllerposition = controllerposition
        self.input = input
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.blue.opacity(0.01))
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        input(angleInDegrees(from: value.startLocation,
                                             to: value.location))
                    })
                    .onEnded({ value in
                        input(angleInDegrees(from: value.startLocation,
                                             to: value.location))
                    })
            )
            .padding()
            .position(position)
//            .if(positionOnTouch(), transform: { view in
//                view
//                    .background() {
//                        Rectangle()
//                            .fill(.black.opacity(0.01))
//                            .onTapGesture { tappedPosition in
//                                position = tappedPosition
//                            }
//                    }
//            })
    }

    private func angle(from origin: CGPoint, to point: CGPoint) -> CGFloat {
        let deltaX = point.x - origin.x
        let deltaY = point.y - origin.y
        let angle = atan2(deltaY, deltaX)
        return angle
    }

    private func angleInDegrees(from origin: CGPoint, to point: CGPoint) -> CGFloat {
        let radians = angle(from: origin, to: point)
        let degrees = radians * 180.0 / CGFloat.pi
        return degrees
    }

    private mutating func positionOnTouch() -> Bool {
        switch controllerposition {
        case .onTouch:
            return true
        case .fixed(let position):
            self.position = position
            return false
        }
    }
}
