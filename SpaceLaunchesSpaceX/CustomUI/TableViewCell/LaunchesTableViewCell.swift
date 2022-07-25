//
//  LaunchesTableViewCell.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 02.07.2022.
//

import Foundation
import UIKit

class LaunchesTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: LaunchesTableViewCell.self)
    
    private lazy var launchCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1058690324, green: 0.1058908626, blue: 0.105864279, alpha: 1)
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var launchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configurate(name: String, date: String, isSuccess: Bool) {
        
        launchIconImageView.image = isSuccess ? UIImage(named: "successLaunch") : UIImage(named: "failedLaunch")
        
//        if isSuccess {
//            launchIconImageView.image = UIImage(named: "successLaunch")
//        } else {
//            launchIconImageView.image = UIImage(named: "failedLaunch")
//        }
        
        contentView.backgroundColor = .black
        nameLabel.text = name
        dateLabel.text = date
        
        setConstraints()
    }
    
}

// MARK: - SetConstraints
extension LaunchesTableViewCell {
    private func setConstraints() {
        contentView.addSubview(launchCellView)
        NSLayoutConstraint.activate([
            launchCellView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 5),
            launchCellView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -5),
            launchCellView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            launchCellView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            launchCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            launchCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            launchCellView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
        ])
        
        launchCellView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: launchCellView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: launchCellView.centerYAnchor, constant: -2),
            nameLabel.leadingAnchor.constraint(equalTo: launchCellView.leadingAnchor, constant: 20),
        ])
        
        launchCellView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: launchCellView.bottomAnchor, constant: 10),
            dateLabel.topAnchor.constraint(equalTo: launchCellView.centerYAnchor, constant: 2),
            dateLabel.leadingAnchor.constraint(equalTo: launchCellView.leadingAnchor, constant: 20),
        ])
        
        launchCellView.addSubview(launchIconImageView)
        NSLayoutConstraint.activate([
            launchIconImageView.centerYAnchor.constraint(equalTo: launchCellView.centerYAnchor),
            launchIconImageView.trailingAnchor.constraint(equalTo: launchCellView.trailingAnchor, constant: -30),
            launchIconImageView.heightAnchor.constraint(equalToConstant: 32),
            launchIconImageView.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
}
