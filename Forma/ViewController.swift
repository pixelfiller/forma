//
//  ViewController.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import UIKit


class ViewController: UIViewController {
    
    var forma: Forma!
    
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
        
        forma = Forma(position: self.view.center, size: 50)
        forma.config = FormaConfig(simplicity: yPercentage,
                                   complexity: 100 - yPercentage,
                                   roundness: xPercentage,
                                   sharpness: 100 - xPercentage)
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
            
            forma.config = FormaConfig(simplicity: yPercentage,
                                       complexity: 100 - yPercentage,
                                       roundness: xPercentage,
                                       sharpness: 100 - xPercentage)
            
            forma.make()
            forma.draw(on: view)
            updateLabels()
        }
    }
    
    
    func updateLabels() {
        simpleLabel.text = "SIMPLE: \(forma.config.simplicity)%"
        complexLabel.text = "COMPLEX: \(forma.config.complexity)%"
        sharpLabel.text = "SHARP: \(forma.config.sharpness)%"
        roundLabel.text = "ROUND: \(forma.config.roundness)%"
    }

    
}


