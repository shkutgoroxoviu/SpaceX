//
//  InfoCell.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 26.08.2022.
//

import UIKit

/// Основная ячейка, которая размером с коллекцию и находится на основной коллекции, одна ячейка = одна ракета
final class InfoCell: UICollectionViewCell {
    static let reuseID = "InfoCell"
    
    private var models: [SpaceshipInfoSections] = []
    var headerDelegate: InfoCellHeaderDelegate?
    var footerDelegate: SpaceshipInfoFooterDelegate?
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       configUI()
    }
    
    func config(with models: [SpaceshipInfoSections]) {
        self.models = models
        tableView.reloadData()
    }
    
    private func configUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: StageCell.reuseId, bundle: nil),
            forCellReuseIdentifier: StageCell.reuseId
        )
        
        tableView.register(
            UINib(nibName: PropertyRow.reuseId, bundle: nil),
            forCellReuseIdentifier: PropertyRow.reuseId
        )
        
        tableView.register(
            UINib(nibName: InfoCellHeader.reuseId, bundle: nil),
            forHeaderFooterViewReuseIdentifier: InfoCellHeader.reuseId
        )
        
        tableView.register(
            UINib(nibName: StageHeader.reuseId, bundle: nil),
            forHeaderFooterViewReuseIdentifier: StageHeader.reuseId
        )
        
        tableView.register(
            UINib(nibName: SpaceshipInfoFooter.reuseId, bundle: nil),
            forHeaderFooterViewReuseIdentifier: SpaceshipInfoFooter.reuseId
        )
        
    }
}

extension InfoCell: UITableViewDataSource, UITableViewDelegate {
    // Задаем хедер
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch models[section] {
        case let .properies(title, _):
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: InfoCellHeader.reuseId) as! InfoCellHeader
            header.config(name: title)
            let backgroundView = UIView(frame: header.bounds)
            backgroundView.backgroundColor = .black
            header.backgroundView = backgroundView
            header.delegate = headerDelegate
            return header
        case let .stage(title, _):
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: StageHeader.reuseId) as! StageHeader
            header.config(title: title)
            let backgroundView = UIView(frame: header.bounds)
            backgroundView.backgroundColor = .black
            header.backgroundView = backgroundView
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == models.count - 1 {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: SpaceshipInfoFooter.reuseId) as! SpaceshipInfoFooter
            footer.delegate = footerDelegate
//            footer.spaceshipName = 
            return footer
        }
        return UITableViewHeaderFooterView()
    }
    
    // Высота хедера
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch models[section] {
        case .properies(_, _):
            return 60
        case .stage(_, _):
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == models.count - 1 {
            return 86
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section] {
        case let .properies(_, model):
            let cell = tableView.dequeueReusableCell(withIdentifier: PropertyRow.reuseId, for: indexPath) as! PropertyRow
            cell.selectionStyle = .none
            cell.config(with: model)
            return cell
        case let .stage(_, model):
            let cell = tableView.dequeueReusableCell(withIdentifier: StageCell.reuseId, for: indexPath) as! StageCell
            cell.selectionStyle = .none
            cell.config(with: model)
            return cell
        }
    }
}
