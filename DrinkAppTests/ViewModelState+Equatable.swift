//
//  ViewModelState+Equatable.swift
//  DrinkAppTests
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import Foundation

@testable import DrinkApp

extension ViewModelState: Equatable where T: Equatable {
    public static func == (lhs: ViewModelState, rhs: ViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.failure(_), .failure(_)):
            return true
        case let (.success(a), .success(b)):
            return a == b
        default:
            return false
        }
    }
}
