//
//  SpaceshipInfoView.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 25.08.2022.
//

import UIKit

/// Основная вью, которая наложена на изображение ракеты
final class SpaceshipInfoView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    
    /// Массив моделей, каждый эллемент это одна ракета
    private var models: [SpaceshipCellModel] = []
    var headerDelegate: InfoCellHeaderDelegate?
    var footerDelegate: SpaceshipInfoFooterDelegate?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        setupXib()
        configuUI()
    }
    
    func config(with models: [SpaceshipCellModel]) {
        self.models = models
        pageControl.numberOfPages = models.count
        reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func setupXib() {
        Bundle.main.loadNibNamed("SpaceshipInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func touchPageControl(_ sender: Any) {
        let indexPath = IndexPath(row: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        print(indexPath.row)
    }
    
    private func configuUI() {
        contentView.layer.cornerRadius = 20
        
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
}

extension SpaceshipInfoView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as! InfoCell
        let model = models[indexPath.row]
        cell.config(with: model.spaceship)
        cell.headerDelegate = headerDelegate
        cell.footerDelegate = footerDelegate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = contentView.bounds.width - 16
        let height = contentView.bounds.height - topConstraint.constant - pageControl.bounds.height - 32
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


