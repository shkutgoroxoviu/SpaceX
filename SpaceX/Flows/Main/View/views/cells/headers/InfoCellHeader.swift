//
//  InfoCellHeader.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 27.08.2022.
//

import UIKit

protocol InfoCellHeaderDelegate {
    func showSettings()
}
// хеддер, на котором находится название ракеты и кнопка, открывающая меню настроек параметров
class InfoCellHeader: UITableViewHeaderFooterView {
    static var reuseId = "InfoCellHeader"
    
    var delegate: InfoCellHeaderDelegate?

    @IBOutlet weak var nameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(name: String) {
        nameLabel.text = name
    }

    @IBAction func showSetting(_ sender: Any) {
        delegate?.showSettings()
    }
}
