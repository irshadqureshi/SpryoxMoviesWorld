// 
//  DashboardLandingInteractor.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation

class DashboardLandingInteractor: DashboardLandingPresenterToInteractor {

    weak var presenter: DashboardLandingInteractorToPresenter?
    var worker: WorkerProtocol?
 
    func getMovieList() {
        worker?.movieListDelegate = self
        worker?.getMovieList()
    }
}

extension DashboardLandingInteractor: GetMovieListProtocol {
    func didSuccessMovieList(response: MovieListModel) {
        presenter?.didSuccessMovieList(response: response)
    }
    
    func didFailedMovieList(with error: ErrorResponse?) {
        presenter?.didFailedMovieList(with: error)
    }
}
