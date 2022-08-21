//
//  FakeErrorNetwork.swift
//  DrinkAppTests
//
//  Created by Vyacheslav Konopkin on 21.08.2022.
//

import Foundation
import Combine

@testable import DrinkApp

struct FakeErrorNetwork: Network {
    func request(url: URL) -> AnyPublisher<Data, Error> {
        Fail(error: TestError.someError)
            .eraseToAnyPublisher()
    }
}
