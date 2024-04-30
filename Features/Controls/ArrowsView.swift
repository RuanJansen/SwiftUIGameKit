//
//  ArrowsView.swift
//  SwiftUIGameKit
//
//  Created by Ruan Jansen on 2024/04/29.
//

import Foundation
import SwiftUI

struct ArrowsView: View {
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
        ZStack {
            Circle()
                .fill(.ultraThinMaterial)
            VStack {
                Button {
                    input(270)
                } label: {
                    Image(systemName: "arrowshape.up.circle")
                        .font(.title)
                }
                Spacer()
                Button {
                    input(90)
                } label: {
                    Image(systemName: "arrowshape.down.circle")
                        .font(.title)
                }
            }        .padding()

            HStack {
                Button {
                    input(180)
                } label: {
                    Image(systemName: "arrowshape.left.circle")
                        .font(.title)
                }
                Spacer()
                Button {
                    input(360)
                } label: {
                    Image(systemName: "arrowshape.right.circle")
                        .font(.title)
                }
            }        .padding()

        }
        .frame(width: 150, height: 150)
        .position(position)
//        .if(positionOnTouch(), transform: { view in
//            view
//                .background() {
//                    Rectangle()
//                        .fill(.black.opacity(0.01))
//                        .onTapGesture { tappedPosition in
//                            position = CGPoint(x: tappedPosition.x,
//                                               y: tappedPosition.y)
//                        }
//                }
//        })
//        .onAppear() {
//            switch controllerposition {
//            case .onTouch:
//                break
//            case .fixed(let position):
//                self.position = position
//            }
//        }
    }

    private func positionOnTouch() -> Bool {
        switch controllerposition {
        case .onTouch:
            return true
        case .fixed(let position):
            return false
        }
    }

    enum Direcection: Double {
        case up = 270
        case down = 90
        case left = 180
        case right = 360
    }
}
