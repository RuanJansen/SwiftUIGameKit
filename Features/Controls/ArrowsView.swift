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
    private var location: CGPoint

    init(position: CGPoint,
         input: @escaping (Double)-> Void) {
        self.location = position
        self.input = input
    }

    var body: some View {
        VStack {
            Spacer()
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
        }
    }

    enum Direcection: Double {
        case up = 270
        case down = 90
        case left = 180
        case right = 360
    }
}
