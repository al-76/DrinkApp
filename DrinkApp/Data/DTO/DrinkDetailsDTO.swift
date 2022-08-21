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

private struct AnyKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        nil
    }
}

extension DrinkDetails {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(String.self, forKey: .category)
        glass = try container.decode(String.self, forKey: .glass)
        instructions = try container.decode(String.self, forKey: .instructions)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        
        let anyContainer = try decoder.container(keyedBy: AnyKey.self)
        ingredients = anyContainer.decodeIngredients()
    }
}

private extension KeyedDecodingContainer where K == AnyKey {
    func decodeIngredients() -> [String] {
        let maxIngredients = 15
        var ingredients = [String]()

        for i in 1...maxIngredients {
            guard let key = AnyKey(stringValue: "strIngredient\(i)"),
                  let item = try? decodeIfPresent(String.self, forKey: key) else {
                continue
            }

            ingredients.append(item)
        }

        return ingredients
    }
}
