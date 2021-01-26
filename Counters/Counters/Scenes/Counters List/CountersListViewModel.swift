//
//  CountersListViewModel.swift
//  Counters
//
//  Created by Me on 22/01/21.
//

import Foundation

struct CountersCellViewModel {
    let title: String
    let value: Int
    let selected: Bool
}

struct ToolBarViewModel {
    let toolbarTitle: String?
    let leftAction: (() -> Void)?
    let righttAction: (() -> Void)?
}

