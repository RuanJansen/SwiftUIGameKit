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
    @State private var position: CGPoint = CGPoint(x: 200, y: 200)
    @State private var controllerPosition: CGPoint = CGPoint(x: 200, y: 500)
    @State private var controllerType: ControllerType = .arrows(position: CGPoint(x: 200, y: 500))
    @State private var isActive: Bool = false
    @State private var presentSettings: Bool = false
    @State private var sensitivity: Float = 5
    @State private var viewFrame: CGRect = CGRect()
    @State var currentAngle: Double = 0.0

    var body: some View {
        GameView {
            GeometryReader { proxy in
                Circle()
                    .fill(.pink)
                    .frame(width: 50)
                    .onAppear {
                        viewFrame = proxy.frame(in: .local)
                        let x = proxy.size.width/2
                        let y = proxy.size.height/3
                        position = CGPoint(x: x, y: y)
                    }
                    .position(position)
            }
        }
        .controlable(controllerType: controllerType) { angle, isActive in
            self.isActive = isActive
            currentAngle = angle
            switch controllerType {
                case .joystick(_):
                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                        if currentAngle != angle {
                            timer.invalidate()
                            updatePosition(with: angle, by: sensitivity)
                        } else if self.isActive {
                            updatePosition(with: angle, by: sensitivity)
                        } else {
                            timer.invalidate()
                        }
                    }
                case .drag:
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                    if currentAngle != angle {
                        timer.invalidate()
                        updatePosition(with: angle, by: sensitivity)
                    } else if self.isActive {
                        updatePosition(with: angle, by: sensitivity)
                    } else {
                        timer.invalidate()
                    }
                }
                case .arrows(_):
                    updatePosition(with: angle, by: sensitivity)
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
            SettingsView(position: $position, controllerPosition: $controllerPosition, controllerType: $controllerType, sensitivity: $sensitivity, isActive: $isActive).presentationDetents([.medium, .large])
        }
        .onAppear() {
            position = CGPoint(x: 200, y: 100)
            controllerPosition = CGPoint(x: 200, y: 500)
            sensitivity = 5
        }
    }

    private func updatePosition(with angle: Double, by sensitivity: Float) {
        let angleInRadians: Float = Float(angle * .pi / 180.0)

        let deltaX = cos(angleInRadians) * sensitivity
        let deltaY = sin(angleInRadians) * sensitivity

        position.x += CGFloat(deltaX)
        position.y += CGFloat(deltaY)
    }
}

struct SettingsView: View {
    @Binding var position: CGPoint
    @Binding var controllerPosition: CGPoint
    @Binding var controllerType: ControllerType
    @Binding var sensitivity: Float
    @Binding var isActive: Bool

    @State var xCoordinate: CGFloat = 0
    @State var yCoordinate: CGFloat = 0

    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()

    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $controllerType) {
                    ForEach(ControllerType.allCases, id: \.self) { option in
                        Text(option.description.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                Form {
//                    Section {
//                        VStack {
//                            HStack {
//                                Text("X Coordinate:")
//                                Spacer()
//                                TextField("", value: $xCoordinate, formatter: formatter)
//                            }
//                            HStack {
//                                Text("Y Coordinate:")
//                                Spacer()
//                                TextField("", value: $yCoordinate, formatter: formatter)
//                            }
//                        }
//                        .keyboardType(.decimalPad)
//                        .scrollDismissesKeyboard(.immediately)
//                        .onAppear {
//                            xCoordinate = controllerPosition.x
//                            yCoordinate = controllerPosition.y
//                        }
//                    } header: {
//                        Text("Control Position")
//                    }

                    Section {
                        VStack {
                            Slider(value: $sensitivity, in: 0...10)
                            Text(String(describing: sensitivity))
                        }
                    } header: {
                        Text("Sensitivity")
                    }
                }

                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        position = CGPoint(x: 200, y: 100)
                        controllerPosition = CGPoint(x: 200, y: 500)
                        sensitivity = 0.5
                        isActive = false
                    } label: {
                        Text("Reset")
                    }
                }

//                ToolbarItem(placement: .keyboard) {
//                    Button {
//                        controllerPosition = CGPoint(x: xCoordinate,
//                                                     y: yCoordinate)
//                    } label: {
//                        Text("Submit")
//                    }
//                }
            }
            .padding(.top)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    DashboardView()
}
