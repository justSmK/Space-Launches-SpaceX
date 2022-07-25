//
//  CustomCollectionViewCell.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 29.06.2022.
//

import Foundation
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CustomCollectionViewCell.self)
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 32
        view.backgroundColor = #colorLiteral(red: 0.1058690324, green: 0.1058908626, blue: 0.105864279, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    func configurateCell(value: String, key: String) {
        valueLabel.text = "\(value)"
        keyLabel.text = key
        setConstraints()
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
}

// MARK: - SetConstraints

extension CustomCollectionViewCell {
    private func setConstraints() {
        
        contentView.addSubview(roundedView)
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
        
        roundedView.addSubview(keyLabel)
        NSLayoutConstraint.activate([
            keyLabel.topAnchor.constraint(equalTo: roundedView.centerYAnchor, constant: 0),
            keyLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 10),
            keyLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -10),
        ])
        
        roundedView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.bottomAnchor.constraint(equalTo: roundedView.centerYAnchor, constant: 0),
            valueLabel.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
        ])
    }
}
