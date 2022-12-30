//
//  LaunchCell.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import UIKit

/// Ячейка с информацией о ступени
class StageCell: UITableViewCell {
    static let reuseId = "StageCell"
    
    @IBOutlet weak var numberOfEngineLabel: UILabel!
    @IBOutlet weak var numberOfFuelLabel: UILabel!
    @IBOutlet weak var burningTimeLabel: UILabel!
    @IBOutlet weak var burningTimeTitleLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(with model: StageCellModel) {
        numberOfFuelLabel.text = "\(model.numberOfFuel)"
        numberOfEngineLabel.text = "\(model.numberOfEngine)"
        
        guard let burningTime = model.burningTime else {
            hidenBurningTime()
            return
        }
        burningTimeLabel.text = "\(burningTime)"
    }
    
    func hidenBurningTime() {
        burningTimeLabel.isHidden = true
        burningTimeTitleLabel.isHidden = true
        secLabel.isHidden = true
    }
}
