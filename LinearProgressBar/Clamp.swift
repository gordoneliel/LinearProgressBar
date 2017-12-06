//
//  Clamp.swift
//  LinearProgressBar
//
//  Created by Eliel A. Gordon on 12/5/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import Foundation

extension Comparable {
    func clamped(lowerBound: Self, upperBound: Self) -> Self {
        return min(max(self, lowerBound), upperBound)
    }
}
