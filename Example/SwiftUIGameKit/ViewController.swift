//
//  ViewController.swift
//  SwiftUIGameKit
//
//  Created by Ruan Jansen on 04/29/2024.
//  Copyright (c) 2024 Ruan Jansen. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let SwiftUIView = NavigationStack { DashboardView() }
        let viewContoller = UIHostingController(rootView: SwiftUIView)
        viewContoller.modalPresentationStyle = .fullScreen
        self.present(viewContoller, animated: animated)
    }

}

