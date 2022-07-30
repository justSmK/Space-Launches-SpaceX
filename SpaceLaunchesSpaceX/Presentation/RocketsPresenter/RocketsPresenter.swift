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
    
    init(view: RocketsViewProtocol) {
        self.view = view
        downloadRockets()
    }
    
    private func downloadRockets() {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        let networkService = NetworkingService()
        networkService.fetchFromUrl(url: url) { [weak self] data in
            do {
                let rockets = try JSONDecoder().decode([Rocket].self, from: data)
                self?.rockets = rockets
                self?.view?.updateValues()
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
    
    func getImageUrl(for index: Int) -> URL {
        return URL(string: "")!
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
    
    
}
