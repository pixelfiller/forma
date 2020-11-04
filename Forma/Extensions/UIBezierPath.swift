//
//  UIBezierPath.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import UIKit

extension UIBezierPath {
    convenience init(points:[CGPoint]) {
        self.init()

        for (index, aPoint) in points.enumerated() {
            if index == 0 {
                self.move(to: aPoint)
            }
            else {
                self.addLine(to: aPoint)
            }
        }
    }
}
