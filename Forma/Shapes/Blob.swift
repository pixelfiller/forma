//
//  Blob.swift
//  Forma
//
//  Created by Anton Evstigneev on 12.11.2020.
//

import Foundation
import UIKit

class Blob: Shape {
    
    var dataPoints: [CGPoint] = []
    let noise = PerlinGenerator()
    
    func generate() -> [CGPoint] {
        self.points = []
        
        let frequency = 10 - self.control.y/10
        let magnitude = 1 - self.control.x/100
        let samples = round(4 * self.size + 20)
        
        for i in stride(from: 0, to: samples + 1, by: 1) {
            let angle = (CGFloat.pi * 2 * i) / samples
            let xoff = CGFloat(cos(angle) * frequency)
            let yoff = CGFloat(sin(angle) * frequency)
            let deformation = noise.perlinNoise(Float(xoff), y: Float(yoff), z: 0, t: 0) + 1
            
            let radius = self.size * (1 + magnitude * CGFloat(deformation))
            
            let x = cos(angle) * radius + self.position.x
            let y = sin(angle) * radius + self.position.y
            
            dataPoints.append(CGPoint(x: x, y: y))
        }

        return dataPoints
    }
}
