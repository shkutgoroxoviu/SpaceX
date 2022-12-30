//
//  LaunchHeader.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import UIKit
// хеддер, который содержит в себе порядковый номер ступеней 
class StageHeader: UITableViewHeaderFooterView {
    
    static let reuseId = "StageHeader"

    @IBOutlet weak var titleLabel: UILabel!

    func config(title: String) {
        titleLabel.text = title
    }
}
