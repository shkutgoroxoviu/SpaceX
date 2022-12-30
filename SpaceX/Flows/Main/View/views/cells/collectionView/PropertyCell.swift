//
//  PropertyCell.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import UIKit

/// Ячейка с коллекцией настроек (диаметр, высота и т.д). Находится внутри PropertyRow
final class PropertyCell: UICollectionViewCell {
    static let reuseId = "PropertyCell"

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    func config(description: String, value: String) {
        valueLabel.text = value
        descriptionLabel.text = description
    }
    
    private func configUI() {
        layer.cornerRadius = 40
        layer.borderWidth = 5
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
    }
}
