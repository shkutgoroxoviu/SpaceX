//
//  LaunchConfigurator.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 24.12.2022.
//

import UIKit

class LaunchConfigurator {
    static func config() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
        let presenter = LaunchPresenter()
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
}
