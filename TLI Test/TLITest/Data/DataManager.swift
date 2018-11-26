//
//  DataManager.swift
//  SkyCoreTest
//
//  Created by Murali Gorantla on 02/11/18.
//  Copyright © 2018 Murali Gorantla. All rights reserved.
//

import Foundation
import Alamofire

enum Uri {
    case mostPopularArticles(section: String, period: Int)
    
    func uriString() -> String {
        switch self {
        case .mostPopularArticles(let section, let timePeriod): return "\(section)/\(timePeriod).json?"
        }
    }
}

/// MARK: - A central place to manipulate data from both remote and local sources.
class DataManager {

    private init() {}
    
    // Singleton instance. Initializing Data manager.
    public static let shared = DataManager()
    
    public func requestMostPopularArticles(online: Bool, parameters: Parameters, completion closure: @escaping ([News], _ error: ServerError?) -> Void) {
        if online {
            // Force to load remote data source.
            ServerManager.shared.getRequest(postData: parameters, apiName: .mostPopularArticles(section: "all-sections", period: 7), closure: { (result) in
                switch result {
                case .success(let data):
                    closure(data, nil)
                case .failure(let error):
                    closure([], error)
                }
            })
        } else {
            // Load Data From DB or Display Message
        }
    }
}
