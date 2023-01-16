//
//  SpaceshipInfoSections.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import Foundation

/// Модель для секций внутри главной ячейки с ракетой, которая скролится вправо-влево
enum SpaceshipInfoSections {
    ///модель для секции с конфигурациями ракеты и общей информацией
    case properies(title: String, id: String, PropertiesRowModel)
    ///модель для секции запусков
    case stage(String, StageCellModel)
}


