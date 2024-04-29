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

    init(input: @escaping (Double)-> Void) {
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
}
