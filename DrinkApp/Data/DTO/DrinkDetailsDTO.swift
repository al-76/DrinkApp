//
//  DrinkDetailsDTO.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 21.08.2022.
//

import Foundation

struct DrinkDetailsResponseDTO: Codable {
    let drinks: [DrinkDetails]
}

// FIXME: Also, there's an option to use DTO Mapper
extension DrinkDetails {
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case glass = "strGlass"
        case instructions = "strInstructions"
        case imageUrl = "strDrinkThumb"
    }
}
