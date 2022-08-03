//
//  SettingsViewController.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var presenter: SettingsPresenterProtocol?
    
    @IBOutlet weak var heightSegmentedControl: UISegmentedControl!
    @IBOutlet weak var diameterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var massSegmentedControl: UISegmentedControl!
    @IBOutlet weak var payloadsSegmentedControl: UISegmentedControl!
    
    @IBAction func heightSegmentedControlAction(_ sender: Any) {
        presenter?.heightValueChanged(currentValue: heightSegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func diameterSegmentedControlAction(_ sender: Any) {
        presenter?.diameterValueChanged(currentValue: diameterSegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func massSegmentedControlAction(_ sender: Any) {
        presenter?.massValueChanged(currentValue: massSegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func payloadsSegmentedControlAction(_ sender: Any) {
        presenter?.payloadsValueChanged(currentValue: payloadsSegmentedControl.selectedSegmentIndex)
    }
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(closeButtonTapped))
        button.tintColor = .white
        return button
    }()
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SettingsPresenter(view: self)
        configurateControl()
        applyCurrentSettings()
        configurateNavigationController()
    }
    
    private func configurateControl() {
        heightSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        heightSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        diameterSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        diameterSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        massSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        massSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        payloadsSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        payloadsSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
    
    private func applyCurrentSettings() {
        guard let presenter = presenter else {
            return
        }
        heightSegmentedControl.selectedSegmentIndex = presenter.getHeightSettings()
        diameterSegmentedControl.selectedSegmentIndex = presenter.getDiameterSettings()
        massSegmentedControl.selectedSegmentIndex = presenter.getMassSettings()
        payloadsSegmentedControl.selectedSegmentIndex = presenter.getPayloadsSettings()
    }
    
    private func configurateNavigationController() {
        navigationItem.rightBarButtonItem = closeButton
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = view.backgroundColor
    }
}

