//
//  DrinksRepository.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation
import Combine

protocol DrinksRepository {
    func read() -> AnyPublisher<[Drink], Error>
}
