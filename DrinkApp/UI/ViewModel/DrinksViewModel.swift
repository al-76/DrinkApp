//
//  DrinksViewModel.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation
import Combine

final class DrinksViewModel {
    typealias State = ViewModelState<[Drink]>
    
    @Published private(set) var state = State.loading
    
    private let repository: DrinksRepository
    
    init(repository: DrinksRepository) {
        self.repository = repository
    }
    
    func fetchData() {
        repository
            .read()
            .map { .success($0) }
            .catch { Just(.failure($0)).eraseToAnyPublisher() }
            .receive(on: DispatchQueue.main)
            .assign(to: &$state)
    }
}
