//
//  DefaultNetwork.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation
import Combine

final class DefaultNetwork: Network {
    func request(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .eraseToAnyPublisher()
    }
}
