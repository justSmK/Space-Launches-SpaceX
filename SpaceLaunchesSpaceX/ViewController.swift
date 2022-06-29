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
        
        configurateSubviews()
        fillData()
    }
    
    
    private func fillData() {
        rocketInfoView.configurate(launchDate: "10 февраля, 2020", country: "США", cost: "100")
        firstStageView.configurate(header: "Первая ступень", enginesCount: "9", fuelMass: "20", burnTime: "120")
        secondStageView.configurate(header: "Первая ступень", enginesCount: "9", fuelMass: "20", burnTime: "120")
    }
    
    private func configurateSubviews() {
        view.addSubview(scrollView)
        setupScrollView()
        scrollView.addSubview(rocketImageView)
        setupRocketImageView()
        scrollView.addSubview(headerView)
        setupHeaderView()
        scrollView.addSubview(collectionView)
        setupCollectionView()
        scrollView.addSubview(rocketInfoView)
        setupRocketInfoView()
        scrollView.addSubview(firstStageView)
        setupFirstStageView()
        scrollView.addSubview(secondStageView)
        setupSecondStageView()
        scrollView.addSubview(launchesButton)
        setupLaunchesButton()
        
        view.addSubview(pageControl)
        setupPageControl()
    }
    
    private func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupHeaderView() {
        headerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: rocketImageView.bottomAnchor, constant: -20).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        headerView.addSubview(rocketNameLabel)
        setupRocketNameLabel()
    }
    
    private func setupRocketImageView() {
        rocketImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        rocketImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -20).isActive = true
        rocketImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        rocketImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        rocketImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    private func setupRocketNameLabel() {
        rocketNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        rocketNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30).isActive = true
        rocketNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: headerView.trailingAnchor, constant: 20).isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupRocketInfoView() {
        rocketInfoView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        rocketInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        rocketInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10).isActive = true
        rocketInfoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupFirstStageView() {
        firstStageView.topAnchor.constraint(equalTo: rocketInfoView.bottomAnchor, constant: 20).isActive = true
        firstStageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        firstStageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10).isActive = true
        firstStageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupSecondStageView() {
        secondStageView.topAnchor.constraint(equalTo: firstStageView.bottomAnchor, constant: 20).isActive = true
        secondStageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        secondStageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10).isActive = true
        secondStageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupPageControl() {
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    private func setupLaunchesButton() {
        launchesButton.topAnchor.constraint(equalTo: secondStageView.bottomAnchor, constant: 40).isActive = true
        launchesButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        launchesButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        launchesButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        launchesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        launchesButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -120).isActive = true
    }
    
}

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
