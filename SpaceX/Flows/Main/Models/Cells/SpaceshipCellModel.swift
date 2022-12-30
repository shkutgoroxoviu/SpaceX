//
//  SpaceshipCell.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import Foundation

/// Модель для коллекции, где ячейка = ракета (которая скролится влево-вправа)
struct SpaceshipCellModel {
    /// массив с моделями для ячеек внутри ячейки с ракетой, которая самая большая( на весь экран и ее можно скролить)
    let spaceship: [SpaceshipInfoSections]
}
