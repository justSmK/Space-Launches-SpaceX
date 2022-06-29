//
//  RocketInfoView.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 29.06.2022.
//

import Foundation
import UIKit

class RocketInfoView: UIView {
    private var firstLaunchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Первый запуск"
        return label
    }()
    
    private var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Страна"
        return label
    }()
    
    private var launchCostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Стоимость запуска"
        return label
    }()
    
    private var firstLaunchValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private var countryValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private var launchCostValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private var firstLaunchRowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var countryRowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var costRowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configurate(launchDate: String, country: String, cost: String) {
        firstLaunchLabel.text = launchDate
        countryLabel.text = country
        launchCostValueLabel.text = "$\(cost) млн"
        setConstraints()
    }
    
}

// MARK: - SetConstraints

extension RocketInfoView {
    private func setConstraints() {
        
        // MARK: FirstLaucnhRowView
        self.addSubview(firstLaunchRowView)
        NSLayoutConstraint.activate([
            firstLaunchRowView.topAnchor.constraint(equalTo: self.topAnchor),
            firstLaunchRowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            firstLaunchRowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            firstLaunchRowView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3),
        ])
        
        firstLaunchRowView.addSubview(firstLaunchLabel)
        NSLayoutConstraint.activate([
            firstLaunchLabel.leadingAnchor.constraint(equalTo: firstLaunchRowView.leadingAnchor, constant: 10),
            firstLaunchLabel.centerYAnchor.constraint(equalTo: firstLaunchRowView.centerYAnchor),
        ])
        
        firstLaunchRowView.addSubview(firstLaunchValueLabel)
        NSLayoutConstraint.activate([
            firstLaunchValueLabel.trailingAnchor.constraint(equalTo: firstLaunchRowView.trailingAnchor, constant: -10),
            firstLaunchValueLabel.centerYAnchor.constraint(equalTo: firstLaunchRowView.centerYAnchor),
        ])
        
        // MARK: CountryRowView
        self.addSubview(countryRowView)
        NSLayoutConstraint.activate([
            countryRowView.topAnchor.constraint(equalTo: firstLaunchRowView.bottomAnchor),
            countryRowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countryRowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countryRowView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3),
        ])
        
        countryRowView.addSubview(countryLabel)
        NSLayoutConstraint.activate([
            countryLabel.leadingAnchor.constraint(equalTo: countryRowView.leadingAnchor, constant: 10),
            countryLabel.centerYAnchor.constraint(equalTo: countryRowView.centerYAnchor),
        ])
        
        countryRowView.addSubview(countryValueLabel)
        NSLayoutConstraint.activate([
            countryValueLabel.trailingAnchor.constraint(equalTo: countryRowView.trailingAnchor, constant: -10),
            countryValueLabel.centerYAnchor.constraint(equalTo: countryRowView.centerYAnchor),
        ])
        
        // MARK: CostRowView
        self.addSubview(costRowView)
        NSLayoutConstraint.activate([
            costRowView.topAnchor.constraint(equalTo: countryRowView.bottomAnchor),
            costRowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            costRowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            costRowView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3),
        ])
        
        costRowView.addSubview(launchCostLabel)
        NSLayoutConstraint.activate([
            launchCostLabel.leadingAnchor.constraint(equalTo: costRowView.leadingAnchor, constant: 10),
            launchCostLabel.centerYAnchor.constraint(equalTo: costRowView.centerYAnchor),
        ])
        
        costRowView.addSubview(launchCostValueLabel)
        NSLayoutConstraint.activate([
            launchCostValueLabel.trailingAnchor.constraint(equalTo: costRowView.trailingAnchor, constant: -10),
            launchCostValueLabel.centerYAnchor.constraint(equalTo: costRowView.centerYAnchor),
        ])
    }
}
