//
//  ExampleApp.swift
//  SwiftUIGameKit_Example
//
//  Created by Ruan Jansen on 2024/04/29.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI

@main
struct ExampleApp: App {
    @State var launching: Bool = true
    var body: some Scene {
        WindowGroup {
            if launching {
                VStack {
                    Text("SwiftUI GameKit")
                    Text("Example App")
                    Image(systemName: "gamecontroller")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                }
                .font(.title)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        launching.toggle()
                    }
                }
            } else {
                DashboardView()
            }
        }
    }
}
