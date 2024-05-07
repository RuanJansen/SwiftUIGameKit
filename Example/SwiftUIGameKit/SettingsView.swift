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
    @Binding var isShowingInputText: Bool


    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Controller Type", selection: $controllerType) {
                    ForEach(ControllerType.allCases, id: \.self) { option in
                        Text(option.description.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Form {

                    Section {
                        Toggle(isOn: $isShowingInputText, label: {
                            Text("Should show angle")
                        })
                    } header: {
                        Text("Angle")
                    }

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
                        sensitivity = 1
                        isActive = false
                    } label: {
                        Text("Reset")
                    }
                }
            }
            .padding(.top)
            .navigationTitle("Settings")
        }
    }
}
