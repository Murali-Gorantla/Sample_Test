//
//  ServerManager.swift
//  SkyCoreTest
//
//  Created by Murali Gorantla on 02/11/18.
//  Copyright © 2018 Murali Gorantla. All rights reserved.
//

import Foundation
import Alamofire

/**
 * Using a Result type addresses this problem by turning each result into two separate states,
 * by using an enum containing a case for each state
 * one for success and one for failure
 **/

enum Result<ValueType, ErrorType> {
    case success(ValueType)
    case failure(ErrorType)
}

/**
 * Using a ServerError type addresses the all errors from server
 * getErrorMessage function returns the error message
 * based on the error type
 **/
enum ServerError {
    
    case invalidRequest(message: String, statusCode: Int)
    case noInternet(message: String, statusCode: Int)
    
    func getErrorMessage() -> String {
        switch self {
            case .invalidRequest(let message, _): return message
            case .noInternet(let message, _): return message
        }
    }
}

let requestTimeOut: TimeInterval = 45 // 45 seconds

let successStatusRange: ClosedRange = 200...299

/**
 * A class which addresses all the server calls/requests
 **/

class ServerManager: NSObject {
    
    static let BASE_URL = "https://api.nytimes.com/"
    let API_PATH = "svc/mostpopular/v2/mostviewed/"
    
    private override init(){}
    
    // Singleton instance. Initializing Server manager.
    public static let shared = ServerManager()
    
    let manager: SessionManager = {
        
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            BASE_URL: .disableEvaluation
        ]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders

        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        manager.session.configuration.timeoutIntervalForRequest = 120
        return manager
    }()
    
    //    MARK: - GetRequest
    
    public func getRequest(postData: Parameters?, apiName: Uri, closure: @escaping (Result<[News], ServerError>) -> Void) {
        var urlString = "\(ServerManager.BASE_URL)\(API_PATH)\(apiName.uriString())"
        urlString = urlString.appendingFormat("api-key=" + Constants.API_KEY)
        print("\(urlString)")
        
        manager.request(urlString).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print(data)
                if let _ = response.result.value {
                    
                    if let _ = response.data {
                        
                        if let statusCode = response.response?.statusCode {
                            
                            if successStatusRange.contains(statusCode) {
                                
                                do {
                                    let news = try JSONDecoder().decode([News].self, from: response.data!, keyPath: "results")
                                    closure(.success(news))
                                } catch {
                                    print(error) // any decoding error will be printed here!
                                }
                                return
                            } else {
                                closure(.failure(.invalidRequest(message: commonMessage, statusCode: 000)))
                                return
                            }
                        } else {
                            // Status Code not in success range
                        }
                    }
                }
            case .failure(let error):
                if let _ = response.response {
                    if let _ = response.data {
                        closure(.failure(.invalidRequest(message: error.localizedDescription, statusCode: 504)))
                        return
                    }
                } else {
                    print("\(error)")
                    closure(.failure(.noInternet(message: noNetwork, statusCode: 000)))
                    return
                }
                print("Post Reponse Error")
            }
        }

    }
    
}
