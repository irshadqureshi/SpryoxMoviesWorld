//
//  URL+Extension.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation

extension URL {
    private static var baseUrl: String {
        return Constants.WebService.baseUrl
    }
    
    private static var accessKey: String {
        return Constants.WebService.accessKey
    }
    
    static func with(string: String) -> URL? {
        return URL(string: "\(baseUrl)\(string)")
    }
    
}
