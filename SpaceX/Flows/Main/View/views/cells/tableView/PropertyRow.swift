//
//  PropertyRow.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import UIKit

/// Ячейка с коллекцией настроек(диаметр. высота и т д) и информацией о первом запуске, цене и тд
final class PropertyRow: UITableViewCell {
    static let reuseId = "PropertyRow"
    var properties: [PropertiesRowCellModel] = []

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var firstStartLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var launchPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configUI()
    }
    
    private func configUI() {
        collectionView.register(
            UINib(nibName: PropertyCell.reuseId, bundle: nil),
            forCellWithReuseIdentifier: PropertyCell.reuseId
        )
    }
    
    func config(with model: PropertiesRowModel) {
        self.properties = model.properties
        firstStartLabel.text = model.firsFlight
        countryLabel.text = model.country
        launchPriceLabel.text = "$\(model.price / 1000000)млн"
        collectionView.reloadData()
    }
}

extension PropertyRow: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PropertyCell.reuseId, for: indexPath) as! PropertyCell
        let property = properties[indexPath.row]
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        switch property {
        case let .diameter(m, ft):
            let value = UserDefaults.diametr == 0 ? m : ft
            let description = UserDefaults.diametr == 0 ? "m" : "ft"
            cell.config(description: "Диаметр, \(description)", value: "\(value)")
        case let .height(m, ft):
            let value = UserDefaults.height == 0 ? m : ft
            let description = UserDefaults.height == 0 ? "m" : "ft"
            cell.config(description: "Высота, \(description)", value: "\(value)")
        case let .mass(kg, lb):
            let value = UserDefaults.mass == 0 ? kg : lb
            let description = UserDefaults.mass == 0 ? "kg" : "lb"
            let formattedNumber = numberFormatter.string(from: NSNumber(value:value))
            cell.config(description: "Масса, \(description)", value: formattedNumber ?? "")
        case let .payload(kg, lb):
            let value = UserDefaults.payload == 0 ? kg : lb
            let description = UserDefaults.payload == 0 ? "kg" : "lb"
            let formattedNumber = numberFormatter.string(from: NSNumber(value:value))
            cell.config(description: "Нагрузка, \(description)", value: formattedNumber ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 112, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}
