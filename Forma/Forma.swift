//
//  Forma.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import Foundation
import UIKit


class Forma {
    
    var config: FormaConfig!
    var position: CGPoint!
    var size: Double!
    var points: [CGPoint]!
    var color = UIColor.white.cgColor
    
    
    init(position: CGPoint, size: Double) {
        self.position = position
        self.size = size
    }
    
    
    func make() {
        self.clear()

        var offset: [Double] = []
    
        for _ in 0...config.complexity/4 + 1 {
            let spikyness = Double.random(in: 1..<5)
            let randomOffsetValue = Double.random(in: -self.size..<self.size)
                * spikyness/5
            offset.append(randomOffsetValue)
        }
        
        for i in 0...config.complexity/4 + 1 {
            let angle = map(Double(i), 0, Double(config.complexity/4 + 1), 0, Double.pi * 2)
            let r = self.size + offset[i]
            let x = Double(self.position.x) + r * cos(angle)
            let y = Double(self.position.y) + r * sin(angle)
            self.points.append(CGPoint(x: x, y: y))
        }
    }
    
    
    func draw(on view: UIView) {
        if !self.points.isEmpty {
            
            for item in view.layer.sublayers! {
                if item.name == "drawing" {
                    item.removeFromSuperlayer()
                }
            }
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.name = "drawing"
            
            let path = UIBezierPath(points: self.points)
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = self.color
            shapeLayer.lineWidth = 2
            shapeLayer.fillColor = self.color
            
            view.layer.addSublayer(shapeLayer)
        }
    }
    
    
    func clear() { self.points = [] }
    
}
