//
//  LaunchesPresenter.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 7/30/22.
//

import Foundation

final class LaunchesPresenter: LaunchesPresenterProtocol {
    weak var view: LaunchesViewProtocol?
    private var rocketId: String
    private var launches: [Launch] = [Launch]()
    
    init(view: LaunchesViewProtocol, rocketId: String) {
        self.view = view
        self.rocketId = rocketId
        downloadLaunches()
    }
    
    private func downloadLaunches() {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else { return }
        
        let networkService = NetworkingService()
        networkService.fetchFromUrl(url: url) { [weak self] data in
            do {
                let allLaunches = try JSONDecoder().decode([Launch].self, from: data)
                self?.launches = allLaunches.filter({ $0.rocket == self?.rocketId })
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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        guard let date = dateFormatter.date(from: stringDate) else {
            return stringDate
        }
        dateFormatter.dateFormat = "d MMMM, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getLaunchDescription(for index: Int) -> (name: String, date: String, isSuccess: Bool) {
        let launch = launches[index]
        let date = formateDate(stringDate: launch.date_utc)
        return (name: launch.name, date: date, isSuccess: launch.success ?? false)
    }
    
    func getLaunchesCount() -> Int {
        return launches.count
    }
}
