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
}

class LaunchPresenter: LaunchPresenterProtocol {
    weak var view: LaunchViewProtocol?
    
    private var service = NetworkService()
    
    var models: [LaunchCellModel] = []
    
    func loadLaunches() {
        service.loadLaunchInfo { [weak self] launches in
            
            guard let self = self else { return }
            
            self.models = launches.compactMap ({ model in
                return LaunchCellModel(
                    spaceshipName: model.name ?? "3213",
                    dateLaunch: model.date ?? "23131")
                })
            self.view?.reloadData()
        }
    }
}
