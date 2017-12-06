//
//  ViewController.swift
//  LinearProgressBarExample
//
//  Created by Eliel Gordon on 11/13/15.
//  Copyright © 2015 Eliel Gordon. All rights reserved.
//

import UIKit
import LinearProgressBar

class ViewController: UIViewController {
    
    @IBOutlet weak var linearProgressBar: LinearProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linearProgressBar.delegate = self
        linearProgressBar.progressValue = 48.8
    }
}

extension ViewController: LinearProgressDelegate {
    func didChangeProgress(fromValue from: Double, toValue to: Double) {
        
    }
}

