//
//  LinearProgressView.swift
//  LinearProgressBar
//
//  Created by Eliel Gordon on 11/13/15.
//  Copyright © 2015 Eliel Gordon. All rights reserved.
//

import UIKit

@IBDesignable
open class LinearProgressView: UIView {
    
    @IBInspectable open var barColor: UIColor = UIColor.green
    @IBInspectable open var trackColor: UIColor = UIColor.yellow
    @IBInspectable open var barThickness: CGFloat = 10
    @IBInspectable open var barPadding: CGFloat = 0
    @IBInspectable open var trackPadding: CGFloat = 6
    @IBInspectable open var progressValue: CGFloat = 0 {
        didSet {
            if (progressValue >= 100) {
                progressValue = 100
            } else if (progressValue <= 0) {
                progressValue = 0
            }
            setNeedsDisplay()
        }
    }
    open var barColorForValue: ((Float)->UIColor)?
    
    fileprivate var trackHeight: CGFloat {
        return barThickness + trackPadding
    }
    
    fileprivate var trackOffset: CGFloat {
        return trackHeight / 2
    }
    
    open override func draw(_ rect: CGRect) {
        drawProgressView()
    }
    
    // Draws the progress bar and track
    func drawProgressView() {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        // Progres Bar Track
        context?.setStrokeColor(trackColor.cgColor)
        context?.beginPath()
        context?.setLineWidth(trackHeight)
        context?.move(to: CGPoint(x: barPadding + trackOffset, y: frame.size.height / 2))
        context?.addLine(to: CGPoint(x: frame.size.width - barPadding - trackOffset, y: frame.size.height / 2))
        context?.setLineCap(CGLineCap.round)
        context?.strokePath()
        
        // Progress Bar
        let barColor = barColorForValue != nil ? barColorForValue!(Float(progressValue)):self.barColor
        context?.setStrokeColor(barColor.cgColor)
        context?.setLineWidth(barThickness)
        context?.beginPath()
        context?.move(to: CGPoint(x: barPadding + trackOffset, y: frame.size.height / 2))
        context?.addLine(to: CGPoint(x: barPadding + trackOffset + calcualtePercentage(), y: frame.size.height / 2))
        context?.setLineCap(CGLineCap.round)
        context?.strokePath()
        
        context?.restoreGState()
    }
    
    /**
     Calculates the percent value of the progress bar
     
     - returns: The percentage of progress
     */
    func calcualtePercentage() -> CGFloat {
        let screenWidth = frame.size.width - (barPadding * 2) - (trackOffset * 2)
        let progress = ((progressValue / 100) * screenWidth)
        return progress < 0 ? barPadding : progress
    }
}
