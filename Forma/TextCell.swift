//
//  TextCell.swift
//  Forma
//
//  Created by Anton Evstigneev on 18.11.2020.
//

import UIKit

class TextCell: UICollectionViewCell {
    let label = UILabel()
    static let reuseIdentifier = "text-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

}

extension TextCell {
    func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = false
        label.font = UIFont(name: "Menlo", size: 11.0)

        contentView.addSubview(label)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset*5),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: inset)
            ])
    }
}
