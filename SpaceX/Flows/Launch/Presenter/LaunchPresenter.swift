//
//  LaunchPresenter.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 25.12.2022.
//

import Foundation

protocol LaunchPresenterProtocol {
    var models: [LaunchCellModel] { get }
    func loadLaunches()
    var title: String { get }
}

class LaunchPresenter: LaunchPresenterProtocol {
    weak var view: LaunchViewProtocol?
    
    private var service = NetworkService()
    
    var models: [LaunchCellModel] = []
    var title: String
    var rocketId: String
    
    init(title: String, rocketId: String) {
        self.title = title
        self.rocketId = rocketId
    }
    
    func loadLaunches() {
        service.loadLaunchInfo { [weak self] launches in
            
            guard let self = self else { return }
            
            self.models = launches.compactMap { model in
                return LaunchCellModel(
                    spaceshipName: model.name ?? "3213",
                    dateLaunch: model.date ?? "23131",
                    success: model.success ?? true,
                    id: model.rocket ?? " "
                    )
            }.filter { $0.id == self.rocketId }
            self.view?.reloadData()
        }
    }
}
