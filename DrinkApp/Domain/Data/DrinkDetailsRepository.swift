//
//  DrinkDetailsRepository.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 21.08.2022.
//

import Foundation
import Combine

protocol DrinkDetailsRepository {
    func read(with id: String) -> AnyPublisher<DrinkDetails, Error>
}
