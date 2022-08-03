//
//  StageView.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 29.06.2022.
//

import Foundation
import UIKit

class StageView: UIView {
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Constants.generalTextColor
        return label
    }()
    
    private lazy var enginesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Constants.nameLabelTextColor
        label.text = "Количество двигателей"
        return label
    }()
    
    private lazy var massOfFuelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Constants.nameLabelTextColor
        label.text = "Количество топлива"
        return label
    }()
    
    private lazy var burnTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Constants.nameLabelTextColor
        label.text = "Время сгорания"
        return label
    }()
    
    private lazy var tonsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Constants.nameLabelTextColor
        label.text = "ton"
        return label
    }()
    
    private lazy var secLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Constants.nameLabelTextColor
        label.text = "sec"
        return label
    }()
    
    private lazy var enginesValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Constants.valueLabelTextColor
        return label
    }()
    
    private lazy var massOfFuelValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Constants.valueLabelTextColor
        return label
    }()
    
    private lazy var burnTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Constants.valueLabelTextColor
        return label
    }()
    
    private lazy var headerRowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var enginesRowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var massFuelRowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var burnFuelRowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configurate(header: String, enginesCount: String, fuelMass: String, burnTime: String) {
        headerLabel.text = header
        enginesValueLabel.text = enginesCount
        massOfFuelValueLabel.text = fuelMass
        burnTimeValueLabel.text = burnTime
        setConstraints()
    }
    
}

// MARK: - SetConstraints

extension StageView {
    private func setConstraints() {
        
        // MARK: FirstLaucnhRowView
        self.addSubview(headerRowView)
        NSLayoutConstraint.activate([
            headerRowView.topAnchor.constraint(equalTo: self.topAnchor),
            headerRowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerRowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerRowView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4),
        ])
        
        headerRowView.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerRowView.leadingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(greaterThanOrEqualTo: headerRowView.trailingAnchor, constant: 10),
            headerLabel.centerYAnchor.constraint(equalTo: headerRowView.centerYAnchor),
        ])
        
        // MARK: EnginesRowView
        self.addSubview(enginesRowView)
        NSLayoutConstraint.activate([
            enginesRowView.topAnchor.constraint(equalTo: headerRowView.bottomAnchor),
            enginesRowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            enginesRowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            enginesRowView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4),
        ])
        
        enginesRowView.addSubview(enginesLabel)
        NSLayoutConstraint.activate([
            enginesLabel.leadingAnchor.constraint(equalTo: enginesRowView.leadingAnchor, constant: 10),
            // enginesLabel.trailingAnchor.constraint(greaterThanOrEqualTo: enginesValueLabel.leadingAnchor, constant: 10),
            enginesLabel.centerYAnchor.constraint(equalTo: enginesRowView.centerYAnchor),
        ])
        
        enginesRowView.addSubview(enginesValueLabel)
        NSLayoutConstraint.activate([
            enginesValueLabel.trailingAnchor.constraint(equalTo: enginesRowView.trailingAnchor, constant: -10),
            enginesValueLabel.centerYAnchor.constraint(equalTo: enginesRowView.centerYAnchor),
        ])
        
        // MARK: MassFuelRowView
        self.addSubview(massFuelRowView)
        NSLayoutConstraint.activate([
            massFuelRowView.topAnchor.constraint(equalTo: enginesRowView.bottomAnchor),
            massFuelRowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            massFuelRowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            massFuelRowView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4),
        ])
        
        massFuelRowView.addSubview(massOfFuelLabel)
        NSLayoutConstraint.activate([
            massOfFuelLabel.leadingAnchor.constraint(equalTo: massFuelRowView.leadingAnchor, constant: 10),
            massOfFuelLabel.centerYAnchor.constraint(equalTo: massFuelRowView.centerYAnchor),
        ])
        
        massFuelRowView.addSubview(tonsLabel)
        NSLayoutConstraint.activate([
            tonsLabel.trailingAnchor.constraint(equalTo: massFuelRowView.trailingAnchor, constant: -10),
            tonsLabel.centerYAnchor.constraint(equalTo: massFuelRowView.centerYAnchor),
        ])
        
        massFuelRowView.addSubview(massOfFuelValueLabel)
        NSLayoutConstraint.activate([
            massOfFuelValueLabel.trailingAnchor.constraint(equalTo: tonsLabel.leadingAnchor, constant: -5),
            massOfFuelValueLabel.centerYAnchor.constraint(equalTo: massFuelRowView.centerYAnchor),
        ])
        
        
        // MARK: BurnFuelRowView
        self.addSubview(burnFuelRowView)
        NSLayoutConstraint.activate([
            burnFuelRowView.topAnchor.constraint(equalTo: massFuelRowView.bottomAnchor),
            burnFuelRowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            burnFuelRowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            burnFuelRowView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4),
        ])
        
        burnFuelRowView.addSubview(burnTimeLabel)
        NSLayoutConstraint.activate([
            burnTimeLabel.leadingAnchor.constraint(equalTo: burnFuelRowView.leadingAnchor, constant: 10),
            burnTimeLabel.centerYAnchor.constraint(equalTo: burnFuelRowView.centerYAnchor),
        ])
        
        burnFuelRowView.addSubview(secLabel)
        NSLayoutConstraint.activate([
            secLabel.trailingAnchor.constraint(equalTo: burnFuelRowView.trailingAnchor, constant: -10),
            secLabel.centerYAnchor.constraint(equalTo: burnFuelRowView.centerYAnchor),
        ])
        
        burnFuelRowView.addSubview(burnTimeValueLabel)
        NSLayoutConstraint.activate([
            burnTimeValueLabel.trailingAnchor.constraint(equalTo: secLabel.leadingAnchor, constant: -5),
            burnTimeValueLabel.centerYAnchor.constraint(equalTo: burnFuelRowView.centerYAnchor),
        ])
        
    }
    
}
