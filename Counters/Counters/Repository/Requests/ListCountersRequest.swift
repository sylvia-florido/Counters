//
//  ListCountersRequest.swift
//  Counters
//
//  Created by Me on 26/01/21.
//

import Foundation


class ListCountersRequest: CountersBaseRequest {
    
    override var endpoint: String {
        return "api/v1/counters"
    }

}
