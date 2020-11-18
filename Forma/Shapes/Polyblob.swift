//
//  Polyblob.swift
//  Forma
//
//  Created by Anton Evstigneev on 12.11.2020.
//

import Foundation
import UIKit


struct PolyblobConfig {
    var simplicity: Int
    var complexity: Int
    var roundness: Int
    var sharpness: Int
}


//class Polyblob: Shape {
//
//    var config: PolyblobConfig!
//
//    func make() {
//        self.clear()
//
//        var offset: [Double] = []
//
//        for _ in 0...config.complexity/4 + 1 {
//            let spikyness = Double.random(in: 1..<15)
//            let randomOffsetValue = Double.random(in: -self.size..<self.size)
//                * spikyness/5
//            offset.append(randomOffsetValue)
//        }
//
//        for i in 0...config.complexity/4 + 1 {
//            let angle = map(Double(i), 0, Double(config.complexity/4 + 1), 0, Double.pi * 2)
//            let r = self.size + offset[i]
//            let x = Double(self.position.x) + r * cos(angle)
//            let y = Double(self.position.y) + r * sin(angle)
//            self.points.append(CGPoint(x: x, y: y))
//        }
//    }
//
//    func controlPoint(current: CGPoint, previous: CGPoint, next: CGPoint, reverse: Bool) -> CGPoint {
//        var p: CGPoint!
//        var n: CGPoint!
//
//        // When 'current' is the first or last point of the array
//        // 'previous' or 'next' don't exist -> replace with 'current'
//        if current == self.points.first || current == self.points.last {
//            p = current
//            n = current
//        } else {
//            p = previous
//            n = next
//        }
//
//        // The smoothing ratio
//        let smoothing = CGFloat(self.config.roundness / 10)
//        // Properties of the opposed-line
//        let o = line(pointA: p, pointB: n)
//        // If is end-control-point, add PI to the angle to go backward
//        let angle = o.angle + (reverse ? CGFloat.pi : 0)
//        let length = o.length * smoothing
//        // The control point position is relative to the current point
//        let x = current.x + cos(angle) * length
//        let y = current.y + sin(angle) * length
//
//        return CGPoint(x: x, y: y)
//    }
//
//
//    func line(pointA: CGPoint, pointB: CGPoint) -> (length: CGFloat, angle: CGFloat) {
//        let lengthX = pointB.x - pointA.x
//        let lengthY = pointB.y - pointA.y
//
//        let length = sqrt(pow(lengthX, 2) + pow(lengthY, 2))
//        let angle = atan2(lengthX, lengthY)
//
//        return (length: length, angle: angle)
//    }
//
//
//    func quadCurvedPathWithPoint(points: [CGPoint]) -> UIBezierPath {
//        let path = UIBezierPath()
//
//        if points.count > 1 {
//            var prevPoint: CGPoint?
//            for (index, point) in points.enumerated() {
//                if index == 0 {
//                    path.move(to: point)
//                } else {
//                    if index == 1 {
//                        path.addLine(to: point)
//                    }
//                    if prevPoint != nil {
//
//                        var nextIndex = index + 1
//                        nextIndex = points.indices.contains(nextIndex) ? nextIndex : 0
//                        let nextPoint = points[nextIndex]
//
//                        var nn = index - 2
//                        nn = points.indices.contains(nn) ? nn : 0
//                        let nnPoint = points[nn]
//
//                        let cp1 = controlPoint(current: point, previous: prevPoint!, next: nnPoint, reverse: false)
//                        let cp2 = controlPoint(current: point, previous: prevPoint!, next: nextPoint, reverse: true)
//                        path.addCurve(to: nextPoint, controlPoint1: cp1, controlPoint2: cp2)
//                    }
//                }
//                prevPoint = point
//            }
//        }
//        return path
//    }
//
//
//    //    func getBezierPathFromPoints(points: [CGPoint]) -> UIBezierPath {
//    //        let bezierPath = UIBezierPath()
//    //        var prevPoint: CGPoint?
//    //        var isFirst = true
//    //
//    //        for point in points {
//    //            if let prevPoint = prevPoint {
//    //                let midPoint = CGPoint(
//    //                    x: (point.x + prevPoint.x) / 2,
//    //                    y: (point.y + prevPoint.y) / 2 )
//    //                if isFirst {
//    //                    bezierPath.addLine(to: midPoint)
//    //                }
//    //                else {
//    //                    bezierPath.addQuadCurve(to: midPoint, controlPoint: prevPoint)
//    //                }
//    //                isFirst = false
//    //            }
//    //            else {
//    //                bezierPath.move(to: point)
//    //            }
//    //            prevPoint = point
//    //        }
//    //        if let prevPoint = prevPoint {
//    //            bezierPath.addLine(to: prevPoint)
//    //        }
//    //
//    //        return bezierPath
//    //    }
//}
