//
//  Drink.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation

struct Drink: Identifiable, Equatable, Codable {
    let id: String
    let name: String
    let imageUrl: String
}
