//
//  ViewController.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 25.08.2022.
//

import UIKit

//AnyObject для того чтобы можно было в презентере написать weak var view. То есть не получилось бы сделать weak
protocol MainViewProtocol: AnyObject {
    func reloadData()
}

class MainViewController: UIViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol?
    
    var headerDelegate: InfoCellHeaderDelegate?
    var footerDelegate: SpaceshipInfoFooterDelegate?
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        configuUI()
    }
    
    // чтобы статусБар не сливался с фоном
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.pageControl.numberOfPages = self?.presenter?.models.count ?? 1
            self?.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func touchPageControl(_ sender: Any) {
        let indexPath = IndexPath(row: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        print(indexPath.row)
    }
    
    private func configuUI() {
        collectionView.layer.cornerRadius = 20
        
        let nib = UINib(nibName: InfoCell.reuseID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: InfoCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // листаем пейджКонтрол вместе с коллекцией
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visiableRect = CGRect()
        visiableRect.origin = collectionView.contentOffset
        visiableRect.size = CGSize(
            width: collectionView.bounds.width,
            height: collectionView.bounds.height
        )
        let visiablePoint = CGPoint(
            x: visiableRect.midX,
            y: visiableRect.midY
        )
        
        guard let visiableIndex = collectionView.indexPathForItem(at: visiablePoint) else { return }
        
        pageControl.currentPage = visiableIndex.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SettingSeque" {
            guard let vc = segue.destination as? SettingViewController else { return }
            
            vc.completion = {
                self.collectionView.reloadData()
            }
        }
        if segue.identifier == "LaunchSegue" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let vc = destinationNavigationController.topViewController as! LaunchViewController
            
            let presenter = LaunchPresenter()
            presenter.view = vc
            vc.presenter = presenter
        }
    }
}

extension MainViewController: InfoCellHeaderDelegate, SpaceshipInfoFooterDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.models.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as! InfoCell
        guard let model = presenter?.models[indexPath.row] else { return cell }
        cell.config(with: model.spaceship)
        cell.headerDelegate = headerDelegate
        cell.footerDelegate = footerDelegate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 16
        let height = collectionView.bounds.height - topConstraint.constant
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func showSettings() {
        performSegue(withIdentifier: "SettingSeque", sender: nil)
    }
    
    func showLaunches() {
        performSegue(withIdentifier: "LaunchSegue", sender: nil)
    }
}


