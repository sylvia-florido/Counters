//
//  CountersBaseRequest.swift
//  Subscriptions
//
//  Created by Me on 26/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import Foundation


class CountersBaseRequest: BaseRequest {
    
    var rawUrl: String {
        get {
            return "https://cornerShopApp.com.br\(endpoint)"
        }
    }
    
    var endpoint: String {
        get {
            return ""
        }
    }
    
    var method: HTTPMethod {
        get {
            return .get
        }
    }
        
    var body: [String : Any]? { return  nil }
    var headers: [String : String]? = nil
    
}
