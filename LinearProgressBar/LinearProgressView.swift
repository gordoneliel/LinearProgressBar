//
//  LinearProgressView.swift
//  LinearProgressBar
//
//  Created by Eliel Gordon on 11/13/15.
//  Copyright © 2015 Eliel Gordon. All rights reserved.
//

import UIKit

/// Draws a progress bar
@IBDesignable
public class LinearProgressView: UIView {
    
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
        }
    }
    open var barColorForValue: ((Float)->UIColor)?
    
    fileprivate var trackHeight: CGFloat {
        return barThickness + trackPadding
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public func draw(_ rect: CGRect) {
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
    
    /// Draws the progress bar and track
    func drawProgressView() {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        // Progress Bar Track
        drawOn(
            context: context,
            lineWidth: barThickness + trackPadding,
            begin: CGPoint(x: barPadding, y: frame.size.height / 2),
            end: CGPoint(x: frame.size.width - barPadding, y: frame.size.height / 2),
            lineCap: .round,
            strokeColor: trackColor
        )
        
        // Progress Bar
        drawOn(
            context: context,
            lineWidth: barThickness,
            begin: CGPoint(x: barPadding, y: frame.size.height / 2),
            end: CGPoint(x: barPadding + calcualtePercentage(), y: frame.size.height / 2),
            lineCap: .round,
            strokeColor: barColor
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
    func calcualtePercentage() -> CGFloat {
        let screenWidth = frame.size.width - (barPadding * 2) - (trackOffset * 2)
        let progress = ((progressValue / 100) * screenWidth)
        return progress < 0 ? barPadding : progress
    }
}
