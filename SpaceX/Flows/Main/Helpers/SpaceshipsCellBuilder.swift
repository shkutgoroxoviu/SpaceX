//
//  SpaceshipsCellBilder.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 30.08.2022.
//

import Foundation

struct SpaceshipsCellBuilder {
    /// Создает модели для ячейки из моделей, которые пришли из сети
    /// - Parameter spaceships: массив моделей пришедших из сети
    /// - Returns: массив моделей для основной коллекции (которая скролится влево-вправо)
    func build(with spaceships: [Spaceship]) -> [SpaceshipCellModel] {
        let cells = spaceships.map { spaceship -> SpaceshipCellModel in
            /// Массив с моделями для ячеек с массой, диаметром и тд
            let propertiesCell = [
                PropertiesRowCellModel.height(spaceship.height.feet ?? 0, spaceship.height.meters ?? 0),
                PropertiesRowCellModel.diameter(spaceship.diameter.feet ?? 0, spaceship.diameter.meters ?? 0),
                PropertiesRowCellModel.mass(spaceship.mass.lb, spaceship.mass.kg),
                PropertiesRowCellModel.payload(spaceship.payloadWeights.first?.kg ?? 0,
                                            spaceship.payloadWeights.first?.lb ?? 0)
            ]
            
            /// Массив ячеек для основной коллекции, где ячейка это одна ракета на весь экран и скролится влево-вправо
            let cell = SpaceshipCellModel(
                spaceship: [
                    SpaceshipInfoSections.properies(
                        title: spaceship.name,
                        PropertiesRowModel(
                            firsFlight: spaceship.firstFlight,
                            country: spaceship.country,
                            price: spaceship.costPerLaunch,
                            properties: propertiesCell
                        )),
                    SpaceshipInfoSections.stage(
                       "Первая ступень",
                       StageCellModel(
                           numberOfEngine: spaceship.firstStage.engines,
                           numberOfFuel: spaceship.firstStage.fuelAmountTons,
                           burningTime: spaceship.firstStage.burnTimeSEC
                       )
                    ),
                    SpaceshipInfoSections.stage(
                       "Вторая ступень",
                       StageCellModel(
                           numberOfEngine: spaceship.secondStage.engines,
                           numberOfFuel: spaceship.secondStage.fuelAmountTons,
                           burningTime: spaceship.secondStage.burnTimeSEC
                       )
                    )
                ]
            )
            
            return cell
        }
        
        return cells
    }
}
