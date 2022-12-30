//
//  LaunchCellModel.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 29.08.2022.
//

import Foundation

/// Модель для StageCell, которая содержит информацию о ступенях
struct StageCellModel {
    /// количество двигателей
    let numberOfEngine: Int
    /// количество топлива
    let numberOfFuel: Double
    /// время сгорания
    let burningTime: Int?
}
