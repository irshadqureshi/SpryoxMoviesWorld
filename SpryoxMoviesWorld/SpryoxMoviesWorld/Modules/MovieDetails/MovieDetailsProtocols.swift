// 
//  MovieDetailsProtocols.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit
import MapKit

// MARK: View -
protocol MovieDetailsPresenterToView: AnyObject {
    var presenter: MovieDetailsViewToPresenter? { get set }
    func populateDetails(from viewModel: MovieDetailsViewModelProtocol)
}

// MARK: Interactor -
protocol MovieDetailsPresenterToInteractor: AnyObject {
    var presenter: MovieDetailsInteractorToPresenter? { get set }
}

// MARK: Router -
protocol MovieDetailsPresenterToRouter: AnyObject {
}

// MARK: Presenter -
protocol MovieDetailsViewToPresenter: AnyObject {
    var view: MovieDetailsPresenterToView? { get set }
    var interactor: MovieDetailsPresenterToInteractor? { get set }
    var router: MovieDetailsPresenterToRouter? { get set }
    var movieDetails: MovieList? { get set }
    
    func viewDidLoad()
}

protocol MovieDetailsInteractorToPresenter: AnyObject {
}

protocol MovieDetailsViewModelProtocol {
    var movieImageURL: URL? { get set }
    var movieTitleString: String? { get set }
    var releaseDateString: String? { get set }
    var ratingString: String? { get set }
    var descriptionString: String? { get set }
    var region: MKCoordinateRegion { get set }
    var annotationArray: [MKPointAnnotation] { get set }
    var location: CLLocationCoordinate2D { get set }
}


