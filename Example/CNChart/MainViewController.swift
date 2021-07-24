//
//  ViewController.swift
//  CNChart
//
//  Created by Chanooo on 07/23/2021.
//  Copyright (c) 2021 Chanooo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttons.forEach {
            $0.layer.cornerRadius = 16
        }
    }

}

