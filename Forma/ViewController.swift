//
//  ViewController.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import UIKit


class ViewController: UIViewController {
    
    var formaConfig: FormaConfig!
    var forma: Forma!
    var drawing = CAShapeLayer()
    
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var complexLabel: UILabel!
    @IBOutlet weak var sharpLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupTap()
        setupForma()
    }

    
    func setupForma() {
        let xPercentage = Int.random(in: 0..<100)
        let yPercentage = Int.random(in: 0..<100)
        
        formaConfig = FormaConfig(simplicity: 100 - yPercentage,
                                   complexity: yPercentage,
                                   roundness: xPercentage,
                                   sharpness: 100 - xPercentage)
        
        forma = Forma(position: self.view.center, size: 50, config: formaConfig)
    }

    
    func setupLabels() {
        sharpLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        roundLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
    
    
    func setupTap() {
        let touchDown = UILongPressGestureRecognizer(target:self, action: #selector(didTouchDown))
        touchDown.minimumPressDuration = 0
        view.addGestureRecognizer(touchDown)
    }
    
    
    @objc func didTouchDown(gesture: UILongPressGestureRecognizer) {
        let touchPoint = gesture.location(in: self.view)
        if gesture.state == .changed {
            let xPercentage = touchPoint.x.getPercentage(from: view.frame.width)
            let yPercentage = touchPoint.y.getPercentage(from: view.frame.height)
            
            formaConfig = FormaConfig(simplicity: 100 - yPercentage,
                                       complexity: yPercentage,
                                       roundness: xPercentage,
                                       sharpness: 100 - xPercentage)
            forma.make()
            drawForma()
            updateLabels()
        }
    }
    
    
    func updateLabels() {
        simpleLabel.text = "SIMPLE: \(formaConfig.simplicity)"
        complexLabel.text = "COMPLEX: \(formaConfig.complexity)"
        sharpLabel.text = "SHARP: \(formaConfig.sharpness)"
        roundLabel.text = "ROUND: \(formaConfig.roundness)"
    }
    
    func drawForma() {
        if !forma.points.isEmpty {
            self.drawing.removeFromSuperlayer()
            
            let shapeLayer = CAShapeLayer()
            
            let path = UIBezierPath(points: forma.points)
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.red.cgColor
            shapeLayer.lineWidth = 2
            shapeLayer.fillColor = nil
            
            drawing = shapeLayer
            
            self.view.layer.addSublayer(drawing)
        }
    }
    
    
}



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
