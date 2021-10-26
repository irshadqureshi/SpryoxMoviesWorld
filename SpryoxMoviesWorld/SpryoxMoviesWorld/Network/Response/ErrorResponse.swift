//
//  ErrorResponse.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation

public struct ErrorResponse: Codable {
    public let code: Int
    public let info: String
}

