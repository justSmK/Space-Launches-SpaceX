//
//  LaunchesViewController.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 02.07.2022.
//

import Foundation
import UIKit

class LaunchesViewController: UIViewController {
    
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
        
        launchesTableView.delegate = self
        launchesTableView.dataSource = self
        view.backgroundColor = .blue
        setConstraints()
    }
    
}

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

extension LaunchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = launchesTableView.dequeueReusableCell(withIdentifier: LaunchesTableViewCell.identifier, for: indexPath)
        guard let launchCell = cell as? LaunchesTableViewCell else {
            return cell
        }
        
        if indexPath.row == 1 {
            launchCell.configurate(name: "Aaa", date: "02 июля, 2022", isSuccess: false)
        } else {
            launchCell.configurate(name: "Bbb", date: "02 июля, 2022", isSuccess: true)
        }
        return cell
    }
}
