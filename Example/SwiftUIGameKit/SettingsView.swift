//
//  SettingsView.swift
//  SwiftUIGameKit_Example
//
//  Created by Ruan Jansen on 2024/05/02.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import SwiftUIGameKit

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
