//
//  LinearProgressBar.swift
//  LinearProgressBar
//
//  Created by Eliel Gordon on 11/13/15.
//  Copyright © 2015 Eliel Gordon. All rights reserved.
//

import UIKit

/// Draws a progress bar
@IBDesignable
open class LinearProgressBar: UIView {
    
    /// The color of the progress bar
    @IBInspectable public var barColor: UIColor = UIColor.green
    /// The color of the base layer of the bar
    @IBInspectable public var trackColor: UIColor = UIColor.yellow
    /// The thickness of the bar
    @IBInspectable public var barThickness: CGFloat = 10
    /// Padding on the left, right, top and bottom of the bar, in relation to the track of the progress bar
    @IBInspectable public var barPadding: CGFloat = 0
    
    /// Padding on the track on the progress bar
    @IBInspectable public var trackPadding: CGFloat = 6 {
        didSet {
            if trackPadding < 0 {
                trackPadding = 0
            }else if trackPadding > barThickness {
                trackPadding = 0
            }
        }
    }
    
    @IBInspectable public var progressValue: CGFloat = 0 {
        didSet {
            progressValue = progressValue.clamped(lowerBound: 0, upperBound: 100)
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
        
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
        
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawProgressView()
    }
    
    /// Draws a line representing the progress bar
    ///
    /// - Parameters:
    ///   - context: context to be mutated
    ///   - lineWidth: width of track or bar
    ///   - begin: point to begin drawing
    ///   - end: point to end drawing
    ///   - lineCap: lineCap style
    ///   - strokeColor: color of bar
    func drawOn(context: CGContext, lineWidth: CGFloat, begin: CGPoint, end: CGPoint, lineCap: CGLineCap, strokeColor: UIColor) {
        context.setStrokeColor(strokeColor.cgColor)
        context.beginPath()
        context.setLineWidth(lineWidth)
        context.move(to: begin)
        context.addLine(to: end)
        context.setLineCap(.round)
        context.strokePath()
    }

    func drawProgressView() {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        let beginPoint = CGPoint(x: barPadding + trackOffset, y: frame.size.height / 2)
        
        
        // Progress Bar Track
        drawOn(
            context: context,
            lineWidth: barThickness + trackPadding,
            begin: beginPoint,
            end: CGPoint(x: frame.size.width - barPadding - trackOffset, y: frame.size.height / 2),
            lineCap: .round,
            strokeColor: trackColor
        )
        
        // Progress bar
        let colorForBar = barColorForValue?(Float(progressValue)) ?? barColor
        
        drawOn(
            context: context,
            lineWidth: barThickness,
            begin: beginPoint,
            end: CGPoint(x: barPadding + trackOffset + calculatePercentage(), y: frame.size.height / 2),
            lineCap: .round,
            strokeColor: colorForBar
        )
    }
    
    /// Clear graphics context and redraw on bounds change
    func setup() {
        clearsContextBeforeDrawing = true
        self.contentMode = .redraw
        clipsToBounds = false
    }
    
    /// Calculates the percent value of the progress bar
    ///
    /// - Returns: The percentage of progress
    func calculatePercentage() -> CGFloat {
        let screenWidth = frame.size.width - (barPadding * 2) - (trackOffset * 2)
        let progress = ((progressValue / 100) * screenWidth)
        return progress < 0 ? barPadding : progress
    }
}
