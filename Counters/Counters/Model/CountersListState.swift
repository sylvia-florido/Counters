//
//  CounterState.swift
//  Counters
//
//  Created by Me on 22/01/21.
//

import Foundation

enum CountersListState {
    case loading
    case loadingError
    case noContent
    
    case refreshing
    case hasContent
    case editing
    case sharing
}


enum CounterCreationState {
    case noContent
    case content
    case saving(title: String)
}
