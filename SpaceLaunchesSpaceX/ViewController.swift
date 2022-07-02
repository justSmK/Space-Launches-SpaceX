//
//  ViewController.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 18.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    private var rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.text = "Rocket"
        return label
    }()
    
    private var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 100, height: 90)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 10, y: 30, width: 0, height: 100), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    private var rocketInfoView: RocketInfoView = {
        let view = RocketInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var firstStageView: StageView = {
        let view = StageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var secondStageView: StageView = {
        let view = StageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var launchesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.1058690324, green: 0.1058908626, blue: 0.105864279, alpha: 1)
        button.setTitle("Посмотреть запуски", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(launchesButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc private func launchesButtonAction() {
        
    }
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.backgroundColor = #colorLiteral(red: 0.03920789436, green: 0.03922066465, blue: 0.03920510784, alpha: 1)
        return pageControl
    }()
    
    
    // MARK: - LyfeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setConstraints()
        fillData()
    }
    
    
    private func fillData() {
        rocketInfoView.configurate(launchDate: "10 февраля, 2020", country: "США", cost: "100")
        firstStageView.configurate(header: "Первая ступень", enginesCount: "9", fuelMass: "20", burnTime: "120")
        secondStageView.configurate(header: "Вторая ступень", enginesCount: "90", fuelMass: "200", burnTime: "1200")
    }
}

// MARK: - SetConstraints
extension ViewController {
    private func setConstraints() {
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        scrollView.addSubview(rocketImageView)
        NSLayoutConstraint.activate([
            rocketImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            rocketImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -20),
            rocketImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rocketImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            rocketImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1/3),
        ])
        
        // MARK: - HeaderView
        scrollView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: rocketImageView.bottomAnchor, constant: -20),
            headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        headerView.addSubview(rocketNameLabel)
        NSLayoutConstraint.activate([
            rocketNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rocketNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
            rocketNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: headerView.trailingAnchor, constant: 20),
        ])
        
        // MARK: -
        
        scrollView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        scrollView.addSubview(rocketInfoView)
        NSLayoutConstraint.activate([
            rocketInfoView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            rocketInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            rocketInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            rocketInfoView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        scrollView.addSubview(firstStageView)
        NSLayoutConstraint.activate([
            firstStageView.topAnchor.constraint(equalTo: rocketInfoView.bottomAnchor, constant: 20),
            firstStageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            firstStageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            firstStageView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        scrollView.addSubview(secondStageView)
        NSLayoutConstraint.activate([
            secondStageView.topAnchor.constraint(equalTo: firstStageView.bottomAnchor, constant: 20),
            secondStageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            secondStageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            secondStageView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        scrollView.addSubview(launchesButton)
        NSLayoutConstraint.activate([
            launchesButton.topAnchor.constraint(equalTo: secondStageView.bottomAnchor, constant: 40),
            launchesButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            launchesButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            launchesButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            launchesButton.heightAnchor.constraint(equalToConstant: 50),
            launchesButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -120),
        ])
        
        
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 100),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
}

// TODO: - Set Sign

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let custom = cell as? CustomCollectionViewCell else {
            return cell
        }
        custom.configurateCell(value: "123456789", key: "aaa")
        return custom
    }
}
