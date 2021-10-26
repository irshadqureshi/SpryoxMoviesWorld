//
//  MovieListModel.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation
import CoreData

// MARK: - MovieListModel
public struct MovieListModel: Codable {
    public let success: Bool?
    public let message: String?
    public var data: [MovieDetails]?

    public init(success: Bool?, message: String?, data: [MovieDetails]?) {
        self.success = success
        self.message = message
        self.data = data
    }
}

// MARK: - MovieDetails
public struct MovieDetails: Codable {
    public let movieCategory, movieCategoryCode: String?
    public var movieList: [MovieList]?

    enum CodingKeys: String, CodingKey {
        case movieCategory = "movie_category"
        case movieCategoryCode = "movie_category_code"
        case movieList = "movie_list"
    }

    public init(movieCategory: String?, movieCategoryCode: String?, movieList: [MovieList]?) {
        self.movieCategory = movieCategory
        self.movieCategoryCode = movieCategoryCode
        self.movieList = movieList
    }
}

// MARK: - MovieList
public struct MovieList: Codable {
    public var isFavourite: Bool?
    public let name, movieListDescription, releaseYear: String?
    public let movieBanner, movieIcon: String?
    public let ratings: String?
    public let theatreLocations: [TheatreLocation]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case movieListDescription = "description"
        case releaseYear = "release_year"
        case movieBanner = "movie_banner"
        case movieIcon = "movie_icon"
        case ratings
        case theatreLocations = "theatre_locations"
    }

    public init(isFavourite: Bool = false, name: String?, movieListDescription: String?, releaseYear: String?, movieBanner: String?, movieIcon: String?, ratings: String?, theatreLocations: [TheatreLocation]?) {
        self.isFavourite = isFavourite
        self.name = name
        self.movieListDescription = movieListDescription
        self.releaseYear = releaseYear
        self.movieBanner = movieBanner
        self.movieIcon = movieIcon
        self.ratings = ratings
        self.theatreLocations = theatreLocations
    }
}

// MARK: - TheatreLocation
public struct TheatreLocation: Codable {
    public let latitude, longitude: String?

    public init(latitude: String?, longitude: String?) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
