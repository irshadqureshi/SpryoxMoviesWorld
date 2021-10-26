//
//  WorkerProtocol.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation
public protocol GetMovieListProtocol: AnyObject {
    func didSuccessMovieList(response: MovieListModel)
    func didFailedMovieList(with error: ErrorResponse?)
}

public protocol WorkerProtocol: AnyObject {
    var movieListDelegate : GetMovieListProtocol? {get set}
    func getMovieList()
}

