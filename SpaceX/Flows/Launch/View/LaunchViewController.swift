//
//  LaunchViewController.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 24.12.2022.
//

import Foundation
import UIKit

protocol LaunchViewProtocol: AnyObject {
    func reloadData()
}

class LaunchViewController: UIViewController, LaunchViewProtocol {
    
    var presenter: LaunchPresenterProtocol?
    
    @IBOutlet weak var backBarItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadLaunches()
        configUI()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        modalPresentationStyle = .fullScreen
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func configUI() {
        collectionView.register(
            UINib(nibName: LaunchCell.reuseId, bundle: nil),
            forCellWithReuseIdentifier: LaunchCell.reuseId
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        
        navigationController?.navigationBar.barStyle = .black
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension LaunchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.models.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCell.reuseId, for: indexPath) as! LaunchCell
        guard let presenter = presenter?.models[indexPath.row] else { return cell }
        
        cell.config(presenter)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 64
        
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
