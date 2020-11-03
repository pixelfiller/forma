//
//  Forma.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import Foundation
import UIKit


class Forma {
    
    var formaConfig: FormaConfig!
    
    var position: CGPoint!
    var size: Double!
    var points: [CGPoint]!
    let spikyness = Double.random(in: 1..<5)
    
    
    init(position: CGPoint, size: Double, config: FormaConfig) {
        self.position = position
        self.size = size
        self.formaConfig = config
    }
    
    
    func make() {
        self.clear()
        var offset: [Double] = []
    
        for _ in 0...formaConfig.complexity {
            let randomOffsetValue = Double.random(in: -self.size..<self.size)
                * spikyness/5
            offset.append(randomOffsetValue)
        }
        
        for i in 0...formaConfig.complexity {
            let angle = map(Double(i), 0, Double(formaConfig.complexity), 0, Double.pi * 2)
            let r = self.size + offset[i]
            let x = Double(self.position.x) + r * cos(angle)
            let y = Double(self.position.y) + r * sin(angle)
            self.points.append(CGPoint(x: x, y: y))
        }
    }
    
    
    func clear() { self.points = [] }
    
}
