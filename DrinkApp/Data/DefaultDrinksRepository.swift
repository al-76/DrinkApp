//
//  DefaultDrinksRepository.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation
import Combine

final class DefaultDrinksRepository: DrinksRepository {
    let apiUrl = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic")!
    
    let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func read() -> AnyPublisher<[Drink], Error> {
        network
            .request(url: apiUrl)
            .decode(type: DrinkResponseDTO.self, decoder: JSONDecoder())
            .tryMap { $0.drinks }
            .eraseToAnyPublisher()
    }
}
