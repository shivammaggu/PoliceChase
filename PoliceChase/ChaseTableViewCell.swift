//
//  ChaseTableViewCell.swift
//  PoliceChase
//
//  Created by Shivam on 24/01/24.
//

import UIKit

class ChaseTableViewCell: UICollectionViewCell {
    
    static let reuseId = "ChaseTableViewCell"
    
    private lazy var exLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(exLabel)
        self.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            self.exLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.exLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.exLabel.widthAnchor.constraint(equalToConstant: 25),
            self.exLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func setupCell(_ text: String) {
        self.exLabel.text = text
    }
}
