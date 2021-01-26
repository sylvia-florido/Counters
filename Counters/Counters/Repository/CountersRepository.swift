//
//  CountersRepository.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import Foundation
import UIKit

public typealias GenericError = ((_ errorMessage: String) -> Void)

enum CountersServiceErrors: String {
    case parseToModel = "Couldn't parse response to model."
    case emptyData = "No data available"
    case otherErrorExample = "Other errors may happen, this coul be a separate file if the error message grow too much"
}

class CountersRepository {
    
    
    // MARK: Shared
    class func sharedInstance() -> CountersRepository {
        struct Singleton {
            static var sharedInstance = CountersRepository()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: Helpers
    func createError(_ error: CountersServiceErrors) -> NSError {
        return NSError(domain: "convertData", code: 1, userInfo: [NSLocalizedDescriptionKey: [NSLocalizedDescriptionKey : error.rawValue]])
    }
    
    // MARK: API calls
        func getCountersList(success: @escaping ((_ response: [Counter]) -> Void),
                             failure: @escaping GenericError) {
    
            let request = ListCountersRequest()
            BaseRequester().taskForGETMethod(request: request, responseType: [Counter].self) { (response, error) in
                if let response = response {
                    success(response)
                } else {
                    failure("Parse error")
                }
            }
        }
    
    func saveCounter(with title: String,
                     success: @escaping ((_ response: [Counter]) -> Void),
                     failure: @escaping GenericError) {

        let request = SaveCounterRequest(counterTitle: title)
        BaseRequester().taskForGETMethod(request: request, responseType: [Counter].self) { (response, error) in
            if let response = response {
                success(response)
            } else {
                failure("Parse error")
            }
        }
    }
    
    func incrementCounter(with counterId: String,
                     success: @escaping ((_ response: [Counter]) -> Void),
                     failure: @escaping GenericError) {

        let request = IncrementCounterRequest(counterId: counterId)
        BaseRequester().taskForGETMethod(request: request, responseType: [Counter].self) { (response, error) in
            if let response = response {
                success(response)
            } else {
                failure("Parse error")
            }
        }
    }
    
    func decrementCounter(with counterId: String,
                     success: @escaping ((_ response: [Counter]) -> Void),
                     failure: @escaping GenericError) {

        let request = DecrementCounterRequest(counterId: counterId)
        BaseRequester().taskForGETMethod(request: request, responseType: [Counter].self) { (response, error) in
            if let response = response {
                success(response)
            } else {
                failure("Parse error")
            }
        }
    }
    
    func deleteCounter(with counterId: String,
                     success: @escaping ((_ response: [Counter]) -> Void),
                     failure: @escaping GenericError) {

        let request = DecrementCounterRequest(counterId: counterId)
        BaseRequester().taskForGETMethod(request: request, responseType: [Counter].self) { (response, error) in
            if let response = response {
                success(response)
            } else {
                failure("Parse error")
            }
        }
    }
    
    // MARK: - Images
    func getImage(withURL url:URL, completion: @escaping (_ image: UIImage?)->()) {
        BaseRequester.getImage(withURL: url, completion: completion)
    }
    
    func cacheImage(withURL url:URL, completion: @escaping (_ success: Bool)->()) {
        BaseRequester.cacheImage(withURL: url, completion: completion)
    }
    
}
