//
//  DefaultDrinkDetailsRepositoryTests.swift
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
                        "idDrink": "testId",
                        "strDrink": "testDrink",
                        "strCategory": "testCategory",
                        "strGlass": "testGlass",
                        "strInstructions": "testInstructions",
                        "strDrinkThumb": "testUrl",
                        "strIngredient1": "testIngredient"
                    }]
                }
                """.utf8))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

private struct FakeEmptyResponseNetwork: Network {
    func request(url: URL) -> AnyPublisher<Data, Error> {
        Just(Data("""
                {
                    "drinks": []
                }
                """.utf8))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

class DefaultDrinkDetailsRepositoryTests: XCTestCase {
    func testRead() throws {
        // Arrange
        let testDrinkDetails = DrinkDetails(id: "testId", name: "testDrink", category: "testCategory", glass: "testGlass", instructions: "testInstructions", imageUrl: "testUrl", ingredients: ["testIngredient"])
        let repository = DefaultDrinkDetailsRepository(network: FakeNetwork())
        
        // Act
        let result = repository.read(with: "test")
        
        //Assert
        XCTAssertEqual(try awaitPublisher(result), testDrinkDetails)
    }
    
    func testReadEmpty() throws {
        // Arrange
        typealias ExpectedError = DefaultDrinkDetailsRepository.NetworkError
        let repository = DefaultDrinkDetailsRepository(network: FakeEmptyResponseNetwork())
        
        // Act
        let result = repository.read(with: "test")
        
        //Assert
        XCTAssertEqual(try awaitError(result) as? ExpectedError,
                       ExpectedError.emptyResponse)
    }
    
    func testReadError() throws {
        // Arrange
        let repository = DefaultDrinkDetailsRepository(network: FakeErrorNetwork())
        
        // Act
        let result = repository.read(with: "test")
        
        //Assert
        XCTAssertEqual(try awaitError(result) as? TestError,
                       TestError.someError)
    }
}
