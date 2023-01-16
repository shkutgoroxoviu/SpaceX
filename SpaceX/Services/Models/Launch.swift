//
//  LaunchCellModel.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 04.01.2023.
//

import Foundation

struct Launch: Codable {
    let name: String?
    let date: String?
    let success: Bool?
    let rocket: String?
    
    enum CodingKeys: String, CodingKey {
        case date = "date_utc"
        case name
        case success
        case rocket
    }
}
