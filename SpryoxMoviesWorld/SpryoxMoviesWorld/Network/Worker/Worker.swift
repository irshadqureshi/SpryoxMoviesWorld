//
//  Worker.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation

public class Worker: WorkerProtocol {

    // MARK: - Properties
    public var movieListDelegate: GetMovieListProtocol?
    public let apiManager: APIManager
    
    // MARK: - Initialization
    public init (apiManager: APIManager = APIManager.sharedInstance) {
        self.apiManager = apiManager
    }
    
    // MARK: - WorkerProtocol
    public func getMovieList() {
        self.apiManager.requestApi(
            apiUrl: Constants.WebService.getMovieListAPI,
            handler: {[weak self] data, response, error in
                if error != nil {
                    self?.movieListDelegate?.didFailedMovieList(with: ErrorResponse(code: -1, info: "Something went wrong"))
                }
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(MovieListModel.self, from: data)
                        self?.movieListDelegate?.didSuccessMovieList(response: response)
                    } catch _ {
                        self?.movieListDelegate?.didFailedMovieList(with: ErrorResponse(code: -1, info: "Something went wrong"))
                    }
                }
            })
        }
}
