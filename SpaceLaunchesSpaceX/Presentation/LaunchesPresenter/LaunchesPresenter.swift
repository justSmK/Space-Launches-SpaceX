//
//  LaunchesPresenter.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 7/30/22.
//

import Foundation
import CoreData

final class LaunchesPresenter: LaunchesPresenterProtocol {
    weak var view: LaunchesViewProtocol?
    private var rocketId: String
    private var launches: [DBLaunch] = [DBLaunch]()
    private var coreDataStack = CoreDataStack()
    
    init(view: LaunchesViewProtocol, rocketId: String) {
        self.view = view
        self.rocketId = rocketId
        downloadLaunches()
    }
    
    private func downloadLaunches() {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else { return }
        
        let networkService = NetworkingService()
        networkService.fetchFromUrl(url: url) { [weak self] data in
            self?.coreDataStack.performSave() { context in
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = context
                do {
                    _ = try decoder.decode([DBLaunch].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            } successSave: {
                let request: NSFetchRequest<DBLaunch> = DBLaunch.fetchRequest()
                guard let id = self?.rocketId else {
                    return
                }
                let predicate = NSPredicate(format: "rocket == %@", id)
                request.sortDescriptors = [NSSortDescriptor(key: #keyPath(DBLaunch.date), ascending: true)]
                request.predicate = predicate
                guard let dbLaunches = self?.coreDataStack.fetch(fetchRequest: request) else {
                    return
                }
                self?.launches = dbLaunches
                self?.view?.updateValues()
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
        let date = formateDate(stringDate: launch.date ?? "")
        return (name: launch.name ?? "", date: date, isSuccess: launch.success ?? false)
    }
    
    func getLaunchesCount() -> Int {
        return launches.count
    }
}
