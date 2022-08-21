//
//  DrinksViewModelTests.swift
//  DrinkAppTests
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import XCTest
import Combine

@testable import DrinkApp

private struct FakeDrinksRepository: DrinksRepository {
    let drinks: [Drink]

    func read() -> AnyPublisher<[Drink], Error> {
        Just(drinks)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

private struct FakeErrorDrinksRepository: DrinksRepository {
    let error: Error

    func read() -> AnyPublisher<[Drink], Error> {
        Fail(error: error)
            .eraseToAnyPublisher()
    }
}

private extension Drink {
    init(_ testId: String) {
        self.init(id: "\(testId)Id",
                  name: "\(testId)Name",
                  imageUrl: "\(testId)Url")
    }
}

class DrinksViewModelTests: XCTestCase {
    func testLoadingState() throws {
        // Arrange
        let viewModel = DrinksViewModel(repository: FakeDrinksRepository(drinks: [Drink("test")]))
        
        // Act
        let result = try awaitPublisher(viewModel.$state)
        
        // Assert
        XCTAssertEqual(result, .loading)
    }
    
    func testFetchData() throws {
        // Arrange
        let testData = [Drink("test1"), Drink("test2"), Drink("test3")]
        let viewModel = DrinksViewModel(repository: FakeDrinksRepository(drinks: testData))
        
        // Act
        viewModel.fetchData()
        
        // Assert
        let result = try awaitPublisher(viewModel.$state.dropFirst())
        XCTAssertEqual(result, .success(testData))
    }
    
    func testFetchDataError() throws {
        // Arrange
        let testError = TestError.someError
        let viewModel = DrinksViewModel(repository: FakeErrorDrinksRepository(error: testError))
        
        // Act
        viewModel.fetchData()
        
        // Assert
        let result = try awaitPublisher(viewModel.$state.dropFirst())
        XCTAssertEqual(result, .failure(testError))
    }
}
