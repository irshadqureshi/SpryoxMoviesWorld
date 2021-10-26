//
//  MovieDetailsPresenter.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation

class MovieDetailsPresenter: MovieDetailsViewToPresenter {
    weak var view: MovieDetailsPresenterToView?
    var interactor: MovieDetailsPresenterToInteractor?
    var router: MovieDetailsPresenterToRouter?
    var movieDetails: MovieList?
    
    func viewDidLoad() {
        view?.populateDetails(from: MovieDetailsViewModel(details: movieDetails))
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorToPresenter {
    
}
