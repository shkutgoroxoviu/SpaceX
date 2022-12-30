//
//  PropertiesRowModel.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import Foundation

/// Модель для PropertyRow, в папке tableView
struct PropertiesRowModel {
    /// Первый старт
    let firsFlight: String
    /// Страна
    let country: String
    /// Цена
    let price: Int
    /// Массив моделей для коллекции с настройками (диаметр, высота и тд)
    let properties: [PropertiesRowCellModel]
}
