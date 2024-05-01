//
//  DragView.swift
//  SwiftUIGameKit
//
//  Created by Ruan Jansen on 2024/04/29.
//

import Foundation
import SwiftUI

struct DragView: View {
    private let input:(Double, Bool)-> Void

    @State private var isActive: Bool = false

    init(input: @escaping (Double, Bool)-> Void) {
        self.input = input
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.black.opacity(0.01))
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        isActive = true
                        input(angleInDegrees(from: value.startLocation,
                                             to: value.location), isActive)
                    })
                    .onEnded({ value in
                        isActive = false
                        input(angleInDegrees(from: value.startLocation,
                                             to: value.location), isActive)
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
