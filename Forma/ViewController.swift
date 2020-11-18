//
//  ViewController.swift
//  Forma
//
//  Created by Anton Evstigneev on 03.11.2020.
//

import UIKit


class ViewController: UIViewController {
    
    var shape: Shape!
    var touchPoint: TouchPoint!
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var shapes = [
        "BLOB",
        "STAR",
        "POLYGON",
        "POLYBLOB",
        "SUPERSHAPE",
        "LINES",
    ]
    var selectedShape: String = "BLOB"
    
    @IBOutlet weak var drawingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        setupTap()
        setupShape()
    }
    
    override var prefersStatusBarHidden: Bool {
         return true
    }
}


// MARK: - Forma Initial Setup
extension ViewController {
    func setupShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "shape"
        drawingView.layer.addSublayer(shapeLayer)
        touchPoint = TouchPoint(x: CGFloat.random(in: 0..<100),
                                y: CGFloat.random(in: 0..<100))
        
        shape = Shape(position: drawingView.center, size: 50)
    }
}


// MARK: - Touch Control Setup
extension ViewController {
    
    func setupTap() {
        let touchDown = UILongPressGestureRecognizer(target:self,
                                                     action: #selector(didTouchDown))
        touchDown.minimumPressDuration = 0
        touchDown.cancelsTouchesInView = false
        drawingView.addGestureRecognizer(touchDown)
    }
    
    
    @objc func didTouchDown(gesture: UILongPressGestureRecognizer) {
        let touch = gesture.location(in: self.drawingView)
        if gesture.state == .changed {
            let x = touch.x.percentage(from: drawingView.frame.width)
            let y = touch.y.percentage(from: drawingView.frame.height)
            touchPoint = TouchPoint(x: x, y: y)
            
            
//            shape.make("Blob")
            let blob = Blob(position: shape.position,
                size: shape.size)
            blob.control = touchPoint
            shape.points = blob.generate()
            shape.draw(on: drawingView)
        }
    }
}


// MARK: - Controls Setup
extension ViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let leadingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                  heightDimension: .fractionalHeight(0.85)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                                  heightDimension: .fractionalHeight(1.0)),
                subitem: leadingItem, count: 1)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .continuous

            return section
        }
        return layout
    }
}

extension ViewController {
    func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
    }
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<TextCell, Int> { (cell, indexPath, identifier) in
            
            cell.label.text = self.shapes[indexPath.item]
            
            if cell.label.text == self.selectedShape {
                cell.contentView.backgroundColor = UIColor.systemGreen
            } else {
                cell.contentView.backgroundColor = UIColor.black
            }
            
            cell.contentView.layer.cornerRadius = 6
            cell.label.textAlignment = .left
            cell.label.font = UIFont(name: "Menlo", size: 11.0)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        let itemsPerSection = shapes.count
        for section in 0..<1 {
            snapshot.appendSections([section])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TextCell
        self.selectedShape = cell.label.text!
        cell.contentView.backgroundColor = UIColor.systemGreen
        collectionView.reloadData()
    }
}
