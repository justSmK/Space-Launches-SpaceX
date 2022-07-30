//
//  LaunchesViewController.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 02.07.2022.
//

import Foundation
import UIKit

class LaunchesViewController: UIViewController, LaunchesViewProtocol {
    
    var presenter: LaunchesPresenterProtocol?
    var rocketId: String = ""
    
    private lazy var launchesTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LaunchesTableViewCell.self, forCellReuseIdentifier: LaunchesTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        return tableView
    }()
    
    
    // MARK: - LyfeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LaunchesPresenter(view: self, rocketId: rocketId)
        launchesTableView.delegate = self
        launchesTableView.dataSource = self
        view.backgroundColor = .black
        setConstraints()
    }
    
    func updateValues() {
        DispatchQueue.main.async {
            self.launchesTableView.reloadData()
        }
    }
    
}

// MARK: - SetConstraints

extension LaunchesViewController {
    private func setConstraints() {
        view.addSubview(launchesTableView)
        NSLayoutConstraint.activate([
            launchesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            launchesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            launchesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            launchesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension LaunchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getLaunchesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = launchesTableView.dequeueReusableCell(withIdentifier: LaunchesTableViewCell.identifier, for: indexPath)
        guard let launchCell = cell as? LaunchesTableViewCell else {
            return cell
        }
        
        guard let launchDescription = presenter?.getLaunchDescription(for: indexPath.row) else {
            return launchCell
        }
        
        launchCell.configurate(name: launchDescription.name,
                               date: launchDescription.date,
                               isSuccess: launchDescription.isSuccess)
        
        return launchCell
    }
}
