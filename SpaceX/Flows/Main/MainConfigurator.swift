//
//  Configurator.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import UIKit

class MainConfigurator {
    static func config() -> MainViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let presenter = MainPresenter()
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
}
