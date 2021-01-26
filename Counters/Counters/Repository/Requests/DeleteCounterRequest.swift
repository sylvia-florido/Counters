//
//  DeleteCounterRequest.swift
//  Counters
//
//  Created by Me on 26/01/21.
//

import Foundation

class DeleteCounterRequest: CountersBaseRequest {
    
    let counterId: String
    
    init(counterId: String) {
        self.counterId = counterId
    }
    
    override var endpoint: String {
        return "api/v1/counter"
    }
    
    override var method: HTTPMethod {
        return .delete
    }
    
    override var body: [String : Any]?  {
        return ["id": counterId]
    }
    
}
