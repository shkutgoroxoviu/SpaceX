//
//  LaunchesCell.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 24.12.2022.
//

import UIKit

class LaunchCell: UICollectionViewCell {
    static let reuseId = "LaunchCell"
    
    var footerDelegate: SpaceshipInfoFooterDelegate?
    
    @IBOutlet weak var spaceshipNameLabel: UILabel!
    @IBOutlet weak var dateLaunchLabel: UILabel!
    @IBOutlet weak var statusImageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    func config(_ model: LaunchCellModel) {
        spaceshipNameLabel.text = model.spaceshipName
        dateLaunchLabel.text = model.dateLaunch
    }
    
    func configUI() {
        layer.cornerRadius = 24
        layer.borderWidth = 5
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
    }
}



