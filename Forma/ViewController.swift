//
//  ViewController.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import UIKit


class ViewController: UIViewController {
    
    var formaConfig: Forma.Config!
    
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var complexLabel: UILabel!
    @IBOutlet weak var sharpLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupTap()
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
            
            formaConfig = Forma.Config(simplicity: 100 - yPercentage, complexity: yPercentage, roundness: xPercentage, sharpness: 100 - xPercentage)
            updateLabels()
        }
    }
    
    func updateLabels() {
        simpleLabel.text = "SIMPLE: \(formaConfig.simplicity)"
        complexLabel.text = "COMPLEX: \(formaConfig.complexity)"
        sharpLabel.text = "SHARP: \(formaConfig.sharpness)"
        roundLabel.text = "ROUND: \(formaConfig.roundness)"
    }
    
    
}

