//
//  DrinkDetailsViewModel.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation
import Combine

final class DrinkDetailsViewModel: ObservableObject {
    typealias State = ViewModelState<DrinkDetails>
    
    @Published private(set) var state = State.loading
        
    private let repository: DrinkDetailsRepository
    
    init(repository: DrinkDetailsRepository) {
        self.repository = repository
    }
    
    func fetchData(with id: String) {
        switch state {
        case .loading, .failure:  // load once or on an error
            repository
                .read(with: id)
                .map { .success($0) }
                .catch { Just(.failure($0)).eraseToAnyPublisher() }
                .receive(on: DispatchQueue.main)
                .assign(to: &$state)
            break

        case .success:
            break // already loaded, exit
        }
    }
}
