//
//  DrinkDTO.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation

struct DrinkResponseDTO: Codable {
    let drinks: [Drink]
}

// FIXME: Also, there's an option to use DTO Mapper
extension Drink {
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageUrl = "strDrinkThumb"
    }
}
