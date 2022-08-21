//
//  DrinkDetails.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation

struct DrinkDetails: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let category: String
    let glass: String
    let instructions: String
    let imageUrl: String
}
