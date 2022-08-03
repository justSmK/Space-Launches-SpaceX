//
//  RocketsPresenter.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 7/30/22.
//

import Foundation

final class RocketsPresenter: RocketsPresenterProtocol {
    
    weak var view: RocketsViewProtocol?
    private var rockets: [Rocket] = [Rocket]()
    var settingsService: SettingsServiceProtocol?
    
    init(view: RocketsViewProtocol) {
        self.view = view
        downloadRockets()
        
        guard let service: SettingsServiceProtocol = ServiceLocator.shared.resolve() else {
            return
        }
        
        settingsService = service
        settingsService?.delegate = self
    }
    
    private func downloadRockets() {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        let networkService = NetworkingService()
        networkService.fetchFromUrl(url: url) { [weak self] data in
            do {
                let rockets = try JSONDecoder().decode([Rocket].self, from: data)
                self?.rockets = rockets
                self?.view?.updateValues()
                print(rockets.count)
            } catch {
                print(error)
            }
        } failure: { error in
            print(error ?? "error")
        }
    }
    
    private func formateDate(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: stringDate) else {
            return stringDate
        }
        dateFormatter.dateFormat = "d MMMM, yyyy"
        return dateFormatter.string(from: date)
    }
    
    // Mark: - RocketsPresenterProtocol
    
    func getRocketInfo(for index: Int) -> (firstLaunch: String, country: String, launchCost: String) {
        let rocket = rockets[index]
        let cost = rocket.cost_per_launch
        let costInMillions = cost / 1_000_000
        let date = formateDate(stringDate: rocket.first_flight)
        return (firstLaunch: date, country: rocket.country, launchCost: String(costInMillions))
    }
    
    func getFirstStageInfo(for index: Int) -> (enginesCount: String, massOfFuel: String, burnTime: String) {
        let rocket = rockets[index]
        let firstStage = rocket.first_stage
        return (enginesCount: String(firstStage.engines), massOfFuel: String(firstStage.fuel_amount_tons), burnTime: String(firstStage.burn_time_sec ?? 0))
    }
    
    func getSecondStageInfo(for index: Int) -> (enginesCount: String, massOfFuel: String, burnTime: String) {
        let rocket = rockets[index]
        let secondStage = rocket.second_stage
        return (enginesCount: String(secondStage.engines), massOfFuel: String(secondStage.fuel_amount_tons), burnTime: String(secondStage.burn_time_sec ?? 0))
    }
    
    func getImageUrl(for index: Int) -> URL? {
        guard let stringUrl = rockets[index].flickr_images.first else {
            return nil
        }
        
        guard let url = URL(string: stringUrl) else {
            return nil
        }
        
        return url
    }
    
    func getPagesCount() -> Int {
        return rockets.count
    }
    
    func getRocketName(for index: Int) -> String {
        return rockets[index].name
    }
    
    func getRocketId(for index: Int) -> String {
        return rockets[index].id
    }
    
    func getCharacteristicsCount() -> Int {
        if rockets.isEmpty {
            return 0
        }
        return 4
    }
    
    func getCharacterictics(for rocketIndex: Int, characteristicIndex: Int) -> (value: String, name: String) {
        switch characteristicIndex {
        case 0:
            guard let service = settingsService else {
                return (
                    value: String(rockets[rocketIndex].height.feet),
                    name: "Высота, ft"
                )
            }
            if service.currentHeightSettings == .m {
                return (
                    value: String(rockets[rocketIndex].height.meters),
                    name: "Высота, \(service.currentHeightSettings.rawValue)"
                )
            } else {
                return (
                    value: String(rockets[rocketIndex].height.feet),
                    name: "Высота, \(service.currentHeightSettings.rawValue)"
                )
            }
            
        case 1:
            guard let service = settingsService else {
                return (
                    value: String(rockets[rocketIndex].diameter.feet),
                    name: "Диаметр, ft"
                )
            }
            if service.currentDiameterSettings == .m {
                return (
                    value: String(rockets[rocketIndex].diameter.meters),
                    name: "Диаметр, \(service.currentDiameterSettings.rawValue)"
                )
            } else {
                return (
                    value: String(rockets[rocketIndex].diameter.feet),
                    name: "Диаметр, \(service.currentDiameterSettings.rawValue)"
                )
            }
            
        case 2:
            guard let service = settingsService else {
                return (
                    value: String(rockets[rocketIndex].mass.kg),
                    name: "Масса, kg"
                )
            }
            if service.currentMassSettings == .kg {
                return (
                    value: String(rockets[rocketIndex].mass.kg),
                    name: "Масса, \(service.currentMassSettings.rawValue)"
                )
            } else {
                return (
                    value: String(rockets[rocketIndex].mass.lb),
                    name: "Масса, \(service.currentMassSettings.rawValue)"
                )
            }
            
        case 3:
            guard let service = settingsService else {
                return (
                    value: String(rockets[rocketIndex].payload_weights[0].kg),
                    name: "Нагрузка, kg"
                )
            }
            if service.currentPayloadsSettings == .kg {
                return (
                    value: String(rockets[rocketIndex].payload_weights[0].kg),
                    name: "Нагрузка, \(service.currentPayloadsSettings.rawValue)"
                )
            } else {
                return (
                    value: String(rockets[rocketIndex].payload_weights[0].lb),
                    name: "Нагрузка, \(service.currentPayloadsSettings.rawValue)"
                )
            }
            
        default:
            return (value: "", name: "")
        }
        
    }
    
}

extension RocketsPresenter: SettingsServiceDelegate {
    func heightSettingsChanged() {
        let indexPath = IndexPath(row: 0, section: 0)
        view?.reloadCollectionViewCell(indexPaths: [indexPath])
    }
    
    func diameterSettingsChanged() {
        let indexPath = IndexPath(row: 1, section: 0)
        view?.reloadCollectionViewCell(indexPaths: [indexPath])
    }
    
    func massSettingsChanged() {
        let indexPath = IndexPath(row: 2, section: 0)
        view?.reloadCollectionViewCell(indexPaths: [indexPath])
    }
    
    func payloadsSettingsChanged() {
        let indexPath = IndexPath(row: 3, section: 0)
        view?.reloadCollectionViewCell(indexPaths: [indexPath])
    }
    
    
}
