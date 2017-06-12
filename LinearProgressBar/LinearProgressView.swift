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
    @IBInspectable open var primaryTextColor: UIColor = UIColor.white
    @IBInspectable open var secondaryTextColor: UIColor = UIColor.white //Created so that a secondary color exists on overlap, if necessary
    @IBInspectable open var showsPercentageText: Bool = false
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
        let reachedPercentage = barPadding + trackOffset + calcualtePercentage()
        context?.addLine(to: CGPoint(x: reachedPercentage, y: frame.size.height / 2))
        context?.setLineCap(CGLineCap.round)
        context?.strokePath()
        context?.restoreGState()
        
        //Percentage Text (just by the padding, in the bar)
        if showsPercentageText {
            let percentage = NSString(format: "%.1f%%", progressValue)
            let textFont: UIFont = UIFont(name: "Helvetica Bold", size: barThickness*1.2)!
            let style = NSMutableParagraphStyle()
            style.alignment = .right
            let textSize = percentage.size(attributes: [NSFontAttributeName: textFont, NSParagraphStyleAttributeName: style])
            let screenWidth = frame.size.width - (barPadding * 2) - (trackOffset * 2)
            let totalSize: CGFloat = barPadding + trackOffset + screenWidth
            let textColor = totalSize - textSize.width < reachedPercentage ? self.secondaryTextColor : self.primaryTextColor
            let textFontAttributes = [
                NSFontAttributeName: textFont,
                NSForegroundColorAttributeName: textColor,
                NSParagraphStyleAttributeName: style
            ]
            let textRect = CGRect(x: 0, y: (frame.size.height-trackHeight)/2, width:totalSize, height: trackHeight)
            percentage.draw(in: textRect, withAttributes: textFontAttributes)
        }
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
