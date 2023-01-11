//
//  MainPresenter.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import Foundation

protocol MainPresenterProtocol {
    func viewDidLoad()
    var models: [SpaceshipCellModel] { get set }
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    private let networkService = NetworkService()
    private let builder = SpaceshipsCellBuilder()
    var models: [SpaceshipCellModel] = []
    
    func viewDidLoad() {
        loadSpaceships()
    }
    
    private func loadSpaceships() {
        networkService.loadSpaceshipsInfo { [weak self] spaceships in
            guard let self = self else { return }
            
            let spaceships = self.builder.build(with: spaceships)
            self.view?.setupInfoView(with: spaceships)
        }
    }
}
