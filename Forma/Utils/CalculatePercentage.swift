//
//  CalculatePercentage.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import UIKit

extension CGFloat {
    func getPercentage(from value: CGFloat) -> Int {
        return Int((100.0 * self) / value)
    }
}
