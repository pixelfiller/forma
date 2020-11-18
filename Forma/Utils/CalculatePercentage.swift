//
//  CalculatePercentage.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import UIKit

extension CGFloat {
    func percentage(from value: CGFloat) -> CGFloat {
        return (100.0 * self) / value
    }
}
