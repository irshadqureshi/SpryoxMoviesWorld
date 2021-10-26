//
//  Constant.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation
class Constants: NSObject {
    
    struct WebService{
        static let accessKey                    =  "ABCD1234PQRS5678"
        static let baseUrl                      =  "http://apis.dev.ganniti.com/api"
        static let getMovieListAPI             =  "/movie_listing.php"
    }
    
    struct Identifiers{
        static let sectionTableViewCell         =  "SectionTableViewCell"
        static let movieTableViewCell            =  "MovieTableViewCell"
    }
    
    struct ImageName{
        static let placeholder                  =  "placeholder.png"
    }
}
