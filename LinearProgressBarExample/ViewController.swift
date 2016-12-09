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
    
    @IBOutlet weak var linearProgressView:LinearProgressView!
    @IBOutlet weak var sliderView: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        linearProgressView.progressValue = CGFloat(sliderView.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeSliderValue(_ sender: UISlider) {
        linearProgressView.progressValue = CGFloat(sender.value)
    }

    @IBAction func changeSwitchValue(_ sender: UISwitch) {
        if sender.isOn {
            // assign color closure
            linearProgressView.barColorForValue = { value in
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
            linearProgressView.progressValue = CGFloat(sliderView.value)
        } else {
            linearProgressView.barColorForValue = nil
        }
    }
}

