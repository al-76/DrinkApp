//
//  Network.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation
import Combine

protocol Network {
    func request(url: URL) -> AnyPublisher<Data, Error>
}
