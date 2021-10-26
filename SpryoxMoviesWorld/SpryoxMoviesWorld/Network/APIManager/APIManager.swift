//
//  APIManager.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation
import UIKit

public enum HttpMethod: String {
    case post = "POST"
    case get  = "GET"
}

public class APIManager: NSObject {
    
    public static let sharedInstance: APIManager = APIManager()
    var dataTask: URLSessionDataTask?
    private override init() {}
    
    public func requestApi(httpMethod: HttpMethod = .get, apiUrl: String, handler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        
        if let url = URL.with(string: apiUrl) {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.rawValue
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let httpHeaderFieldContentType  = "Content-Type"
            let contentTypeApplicationJson  = "application/json"
            urlRequest.timeoutInterval = 60.0
            urlRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
            urlRequest.addValue(contentTypeApplicationJson, forHTTPHeaderField: httpHeaderFieldContentType)
            urlRequest.addValue(Constants.WebService.accessKey, forHTTPHeaderField: "authtoken")

            print(urlRequest)
            dataTask?.cancel()
            dataTask = session.dataTask(with: urlRequest) { data, response, error in
                handler(data, response, error)
            }
            dataTask?.resume()
        }
    }
}

