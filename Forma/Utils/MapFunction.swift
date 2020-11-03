//
//  MapFunction.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import Foundation


public func map(_ value: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
    return (value - x1) * (y2 - x2) / (y1 - x1) + x2
}
