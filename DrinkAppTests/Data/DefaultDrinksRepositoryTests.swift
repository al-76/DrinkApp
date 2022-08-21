//
//  DefaultDrinksRepositoryTests.swift
//  DrinkAppTests
//
//  Created by Vyacheslav Konopkin on 21.08.2022.
//

import XCTest
import Combine

@testable import DrinkApp

private struct FakeNetwork: Network {
    func request(url: URL) -> AnyPublisher<Data, Error> {
        Just(Data("""
                {
                    "drinks": [{
                        "strDrink": "testDrink",
                        "strDrinkThumb": "testUrl",
                        "idDrink": "testId"
                    }]
                }
                """.utf8))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

class DefaultDrinksRepositoryTests: XCTestCase {
    func testRead() throws {
        // Arrange
        let testDrink = [Drink(id: "testId", name: "testDrink", imageUrl: "testUrl")]
        let repository = DefaultDrinksRepository(network: FakeNetwork())
        
        // Act
        let result = repository.read()
        
        // Assert
        XCTAssertEqual(try awaitPublisher(result), testDrink)
    }
    
    func testReadError() throws {
        // Arrange
        let repository = DefaultDrinksRepository(network: FakeErrorNetwork())
        
        // Act
        let result = repository.read()
        
        // Assert
        XCTAssertEqual(try awaitError(result) as? TestError, TestError.someError)
    }
}
