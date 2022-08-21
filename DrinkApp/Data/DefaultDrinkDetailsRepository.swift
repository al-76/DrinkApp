//
//  DefaultDrinkDetailsRepository.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 21.08.2022.
//

import Foundation
import Combine

final class DefaultDrinkDetailsRepository: DrinkDetailsRepository {
    enum NetworkError: Error {
        case emptyResponse
    }
    
    let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func read(with id: String) -> AnyPublisher<DrinkDetails, Error> {
        let apiUrl = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)")!
        return network
            .request(url: apiUrl)
            .decode(type: DrinkDetailsResponseDTO.self, decoder: JSONDecoder())
            .tryMap {
                guard let result = $0.drinks.first else {
                    throw NetworkError.emptyResponse
                }
                return result
            }
            .eraseToAnyPublisher()
    }
}
