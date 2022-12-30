//
//  PropertiesCellModel.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import Foundation

/// Для коллекци внутри строки
enum PropertiesRowCellModel {
    case height(Double, Double)
    case diameter(Double, Double)
    case mass(Int, Int)
    case payload(Int, Int)
}
