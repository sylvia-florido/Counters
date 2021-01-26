//
//  SaveCounterRequest.swift
//  Counters
//
//  Created by Me on 26/01/21.
//

import Foundation

class SaveCounterRequest: CountersBaseRequest {
    
    let counterTitle: String
    
    init(counterTitle: String) {
        self.counterTitle = counterTitle
    }
    
    override var endpoint: String {
        return "api/v1/counter"
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var body: [String : Any]?  {
        return ["title": counterTitle]
    }

}
