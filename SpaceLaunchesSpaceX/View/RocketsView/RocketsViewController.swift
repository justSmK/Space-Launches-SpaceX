//
//  RocketsViewController.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 18.03.2022.
//

import UIKit
import Kingfisher

@propertyWrapper
public struct UsesAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}

class RocketsViewController: UIViewController, RocketsViewProtocol {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Properties
    
    var presenter: RocketsPresenterProtocol?
    
    //    @UsesAutoLayout
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = Constants.backgroundColor
        return scrollView
    }()
    
    //    @UsesAutoLayout
    private lazy var rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    //    @UsesAutoLayout
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.backgroundColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    //    @UsesAutoLayout
    private lazy var rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = Constants.generalTextColor
        label.text = "Rocket"
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = Constants.nameLabelTextColor
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func settingsButtonTapped() {
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        self.present(settingsNavigationController, animated: true, completion: nil)
    }
    
    //    @UsesAutoLayout
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 100, height: 90)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 10, y: 30, width: 0, height: 100), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //        collectionView.backgroundColor = .black
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.backgroundColor = Constants.backgroundColor
        return collectionView
    }()
    
    //    @UsesAutoLayout
    private lazy var rocketInfoView: RocketInfoView = {
        let view = RocketInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //    @UsesAutoLayout
    private lazy var firstStageView: StageView = {
        let view = StageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //    @UsesAutoLayout
    private var secondStageView: StageView = {
        let view = StageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //    @UsesAutoLayout
    private lazy var launchesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.cellBackgroundColor
        button.setTitle("Посмотреть запуски", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(launchesButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc private func launchesButtonAction() {
        let launchesViewController = LaunchesViewController()
        let rocketId = presenter?.getRocketId(for: pageControl.currentPage)
        launchesViewController.rocketId = rocketId ?? ""
        let rocketName = presenter?.getRocketName(for: pageControl.currentPage)
        launchesViewController.rocketName = rocketName ?? ""
        navigationController?.pushViewController(launchesViewController, animated: true)
    }
    
    //    @UsesAutoLayout
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.backgroundColor = Constants.pageControlBackgroundColor
        pageControl.addTarget(self, action: #selector(pageDidChange), for: .valueChanged)
        return pageControl
    }()
    
    @objc private func pageDidChange() {
        updateValues()
    }
    
    
    // MARK: - LyfeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RocketsPresenter(view: self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configurateNavigationBar()
        
        setConstraints()
        fillData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func updateValues() {
        DispatchQueue.main.async {
            self.fillData()
            self.collectionView.reloadData()
        }
    }
    
    func reloadCollectionViewCell(indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }
    
    
    private func fillData() {
        
        guard let pagesCount = presenter?.getPagesCount() else {
            return
        }
        
        if pagesCount < 1 {
            return
        }
        
        pageControl.numberOfPages = pagesCount
        
        setRocketInfoValues()
        setFirstStageValues()
        setSecondStageValues()
        
        guard let name = presenter?.getRocketName(for: pageControl.currentPage) else {
            return
        }
        
        rocketNameLabel.text = name
        
        guard let url = presenter?.getImageUrl(for: pageControl.currentPage) else {
            return
        }
        
        rocketImageView.kf.setImage(with: url)
    }
    
    private func setRocketInfoValues() {
        guard let rocketInfo = presenter?.getRocketInfo(for: pageControl.currentPage) else {
            return
        }
        
        rocketInfoView.configurate(launchDate: rocketInfo.firstLaunch, country: rocketInfo.country, cost: rocketInfo.launchCost)
    }
    
    private func setFirstStageValues() {
        guard let firstStageInfo = presenter?.getFirstStageInfo(for: pageControl.currentPage) else {
            return
        }
        
        firstStageView.configurate(header: "Первая ступень", enginesCount: firstStageInfo.enginesCount, fuelMass: firstStageInfo.enginesCount, burnTime: firstStageInfo.burnTime)
    }
    
    private func setSecondStageValues() {
        guard let secondStageInfo = presenter?.getSecondStageInfo(for: pageControl.currentPage) else {
            return
        }
        secondStageView.configurate(header: "Вторая ступень", enginesCount: secondStageInfo.enginesCount, fuelMass: secondStageInfo.enginesCount, burnTime: secondStageInfo.burnTime)
    }
    
    private func configurateNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        backButton.tintColor = .white
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backBarButtonItem = backButton
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension RocketsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCharacteristicsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath)
        guard let custom = cell as? CustomCollectionViewCell else {
            return cell
        }
        
        guard let characteristics = presenter?.getCharacterictics(for: pageControl.currentPage, characteristicIndex: indexPath.row) else {
            return custom
        }
        custom.configurateCell(value: characteristics.value, key: characteristics.name)
        
        return custom
    }
}

// MARK: - SetConstraints
extension RocketsViewController {
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
            rocketImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -50),
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
        
        headerView.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            settingsButton.centerYAnchor.constraint(equalTo: rocketNameLabel.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            settingsButton.widthAnchor.constraint(equalToConstant: 30)
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
