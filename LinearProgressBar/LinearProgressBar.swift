//
//  LinearProgressBar.swift
//  LinearProgressBar
//
//  Created by Eliel Gordon on 11/13/15.
//  Copyright © 2015 Eliel Gordon. All rights reserved.
//

#if os(iOS) || os(tvOS)
public typealias LPBView = UIView
public typealias LPBColor = UIColor
#elseif os(macOS)
public typealias LPBView = NSView
public typealias LPBColor = NSColor
#endif

fileprivate extension Comparable {
    
    func clamped(lowerBound: Self, upperBound: Self) -> Self {
        return min(max(self, lowerBound), upperBound)
    }
    
}

open class LinearProgressBar: LPBView {
    
    /// The color of the progress bar.
    public var barColor: LPBColor = LPBColor.green
    /// The color of the base layer of the bar.
    public var trackColor: LPBColor = LPBColor.yellow
    /// The thickness of the bar.
    public var barThickness: CGFloat = 10
    /// Padding on the left, right, top and bottom of the bar, in relation to the track of the progress bar.
    public var barPadding: CGFloat = 0
    /// Line cap of the bar.
    public var lineCap: CGLineCap = .round
    
    /// Padding on the track on the progress bar.
    public var trackPadding: CGFloat = 6 {
        didSet {
            if trackPadding < 0 {
                trackPadding = 0
            } else if trackPadding > barThickness {
                trackPadding = 0
            }
        }
    }
    
    public var progressValue: CGFloat = 0 {
        didSet {
            progressValue = progressValue.clamped(lowerBound: 0, upperBound: 100)
            #if os(iOS) || os(tvOS)
            setNeedsDisplay()
            #elseif os(macOS)
            needsDisplay = true
            #endif
        }
    }
    
    open var barColorForValue: ((Double) -> LPBColor)?
    
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
    
    open override func draw(_ dirtyRect: CGRect) {
        super.draw(dirtyRect)
        #if os(macOS)
        NSGraphicsContext.current?.cgContext.clear(dirtyRect)
        #endif
        drawProgressView()
    }
    
    /// Draws a line representing the progress bar.
    ///
    /// - Parameters:
    ///   - context: Context to be mutated.
    ///   - lineWidth: Width of track or bar.
    ///   - begin: Point to begin drawing.
    ///   - end: Point to end drawing.
    ///   - lineCap: Line cap style.
    ///   - strokeColor: Bar color.
    func drawOn(context: CGContext,
                lineWidth: CGFloat,
                begin: CGPoint,
                end: CGPoint,
                lineCap: CGLineCap,
                strokeColor: LPBColor) {
        context.setStrokeColor(strokeColor.cgColor)
        context.beginPath()
        context.setLineWidth(lineWidth)
        context.move(to: begin)
        context.addLine(to: end)
        context.setLineCap(lineCap)
        context.strokePath()
    }
    
    func drawProgressView() {
        #if os(iOS) || os(tvOS)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        #elseif os(macOS)
        guard let context = NSGraphicsContext.current?.cgContext else {
            return
        }
        #endif
        let beginPoint = CGPoint(x: barPadding + trackOffset, y: frame.size.height / 2)
        // Progress Bar Track
        drawOn(
            context: context,
            lineWidth: barThickness + trackPadding,
            begin: beginPoint,
            end: CGPoint(x: frame.size.width - barPadding - trackOffset, y: frame.size.height / 2),
            lineCap: lineCap,
            strokeColor: trackColor
        )
        // Progress bar
        let colorForBar = barColorForValue?(Double(progressValue)) ?? barColor
        drawOn(
            context: context,
            lineWidth: barThickness,
            begin: beginPoint,
            end: CGPoint(x: barPadding + trackOffset + calculatePercentage(), y: frame.size.height / 2),
            lineCap: .round,
            strokeColor: colorForBar
        )
    }
    
    /// Clear graphics context and redraw on bounds change.
    func setup() {
        #if os(iOS) || os(tvOS)
        clearsContextBeforeDrawing = true
        self.contentMode = .redraw
        clipsToBounds = false
        #elseif os(macOS)
        wantsLayer = true
        layer!.masksToBounds = true
        #endif
    }
    
    /// Calculates the percent value of the progress bar.
    ///
    /// - Returns: The percentage of progress.
    func calculatePercentage() -> CGFloat {
        let screenWidth = frame.size.width - (barPadding * 2) - (trackOffset * 2)
        let progress = ((progressValue / 100) * screenWidth)
        return progress < 0 ? barPadding : progress
    }
    
}
