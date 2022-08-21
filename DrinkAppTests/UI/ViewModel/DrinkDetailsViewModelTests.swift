//
//  DrinkDetailsViewModelTests.swift
//  DrinkAppTests
//
//  Created by Vyacheslav Konopkin on 21.08.2022.
//

import XCTest
import Combine

@testable import DrinkApp

private final class FakeDrinkDetailsRepository: DrinkDetailsRepository {
    var called = 0
    
    func read(with id: String) -> AnyPublisher<DrinkDetails, Error> {
        called += 1
        return Just(DrinkDetails(id))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

private final class FakeErrorDrinkDetailsRepository: DrinkDetailsRepository {
    private let error: Error
    
    var called = 0
    
    init(error: Error) {
        self.error = error
    }
    
    func read(with id: String) -> AnyPublisher<DrinkDetails, Error> {
        called += 1
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}

private extension DrinkDetails {
    init(_ testId: String) {
        self.init(id: "\(testId)Id",
                  name: "\(testId)Name",
                  category: "\(testId)Category",
                  glass: "\(testId)Glass",
                  instructions: "\(testId)Instructions",
                  imageUrl: "\(testId)ImageUrl")
    }
}

class DrinkDetailsViewModelTests: XCTestCase {
    func testLoadingState() throws {
        // Arrange
        let viewModel = DrinkDetailsViewModel(repository: FakeDrinkDetailsRepository())
        
        // Act
        let result = try awaitPublisher(viewModel.$state)
        
        // Assert
        XCTAssertEqual(result, .loading)
    }
    
    func testFetchData() throws {
        // Arrange
        let testId = "test"
        let testData = DrinkDetails(testId)
        let viewModel = DrinkDetailsViewModel(repository: FakeDrinkDetailsRepository())
        
        // Act
        viewModel.fetchData(with: testId)
        
        // Assert
        let result = try awaitPublisher(viewModel.$state.dropFirst())
        XCTAssertEqual(result, .success(testData))
    }
    
    func testFetchDataError() throws {
        // Arrange
        let testError = TestError.someError
        let viewModel = DrinkDetailsViewModel(repository: FakeErrorDrinkDetailsRepository(error: testError))
        
        // Act
        viewModel.fetchData(with: "test")
        
        // Assert
        let result = try awaitPublisher(viewModel.$state.dropFirst())
        XCTAssertEqual(result, .failure(testError))
    }
    
    func testFetchDataTwice() throws {
        // Arrange
        let repository = FakeDrinkDetailsRepository()
        let viewModel = DrinkDetailsViewModel(repository: repository)
        
        // Act
        viewModel.fetchData(with: "test1")
        try awaitPublisher(viewModel.$state.dropFirst())
        viewModel.fetchData(with: "test2")
        
        // Assert
        XCTAssertEqual(repository.called, 1)
    }
    
    func testFetchDataErrorTwice() throws {
        // Arrange
        let repository = FakeErrorDrinkDetailsRepository(error: TestError.someError)
        let viewModel = DrinkDetailsViewModel(repository: repository)
        
        // Act
        viewModel.fetchData(with: "test1")
        try awaitPublisher(viewModel.$state.dropFirst())
        viewModel.fetchData(with: "test2")

        
        // Assert
        XCTAssertEqual(repository.called, 2)
    }
}
