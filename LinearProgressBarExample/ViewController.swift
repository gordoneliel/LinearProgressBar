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
    
    @IBOutlet weak var endCapType: UISegmentedControl!
    @IBOutlet weak var linearProgressBar: LinearProgressBar!
    @IBOutlet weak var sliderView: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linearProgressBar.progressValue = 48.8
    }
    
    @IBAction func changeSliderValue(_ sender: UISlider) {
        linearProgressBar.progressValue = CGFloat(sender.value)
    }
    
    @IBAction func endCapTypeChanged(_ sender: UISegmentedControl) {
        linearProgressBar.capType = Int32(sender.selectedSegmentIndex)
    }
    
    @IBAction func changeSwitchValue(_ sender: UISwitch) {
        if sender.isOn {
            // assign color closure
            linearProgressBar.barColorForValue = { value in
                switch value {
                case 0..<20:
                    return UIColor.red
                case 20..<60:
                    return UIColor.orange
                case 60..<80:
                    return UIColor.yellow
                default:
                    return UIColor.green
                }
            }
            // refresh
            linearProgressBar.progressValue = CGFloat(sliderView.value)
        } else {
            linearProgressBar.barColorForValue = nil
        }
    }
}

