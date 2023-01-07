//
//  ViewController.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 25.08.2022.
//

import UIKit

//AnyObject для того чтобы можно было в презентере написать weak var view. То есть не получилось бы сделать weak
protocol MainViewProtocol: AnyObject {
    func setupInfoView(with models: [SpaceshipCellModel])
}

class MainViewController: UIViewController, MainViewProtocol {
    
    var presenter: MainPresenterProtocol?

    @IBOutlet weak var spaceshipInfoView: SpaceshipInfoView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    // чтобы статусБар не сливался с фоном
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupInfoView(with models: [SpaceshipCellModel]) {
        DispatchQueue.main.async {
            self.spaceshipInfoView.config(with: models)
            self.spaceshipInfoView.headerDelegate = self
            self.spaceshipInfoView.footerDelegate = self
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SettingSeque" {
            guard let vc = segue.destination as? SettingViewController else { return }
            
            vc.completion = {
                self.spaceshipInfoView.reloadData()
            }
        }
        if segue.identifier == "segueShowNavigation" {
            if let destVC = segue.destination as? UINavigationController, let targetController = destVC.topViewController as? LaunchViewController {
                
            }
            
            let presenter = LaunchPresenter()
            presenter.view = vc
            vc.presenter = presenter
        }
    }
}

extension MainViewController: InfoCellHeaderDelegate, SpaceshipInfoFooterDelegate {
    func showSettings() {
        performSegue(withIdentifier: "SettingSeque", sender: nil)
    }
    
    func showLaunches() {
        performSegue(withIdentifier: "segueShowNavigation", sender: nil)
    }
}


