//
//  Counter.swift
//  Counters
//
//  Created by Me on 22/01/21.
//

import Foundation

class Counter: Decodable {
    let id: String
    let title: String
    var count: Int
    var selected: Bool
    
    init(id: String, title: String, count: Int, selected: Bool = false) {
        self.id = id
        self.title = title
        self.count = count
        self.selected = selected
    }
}

class Counters {
    static func sum(_ counters: [Counter]) -> Int {
        return counters.sum(for: \.count)
    }
    
  
}
