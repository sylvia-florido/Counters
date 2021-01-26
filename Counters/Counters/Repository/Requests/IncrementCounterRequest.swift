//
//  IncrementCounterRequest.swift
//  Counters
//
//  Created by Me on 26/01/21.
//

import Foundation

class IncrementCounterRequest: CountersBaseRequest {
    
    let counterId: String
    
    init(counterId: String) {
        self.counterId = counterId
    }
    
    override var endpoint: String {
        return "api/v1/counter/inc"
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var body: [String : Any]?  {
        return ["id": counterId]
    }
    
}
