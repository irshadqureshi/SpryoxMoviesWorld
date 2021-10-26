// 
//  DashboardLandingProtocols.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit

// MARK: View -
protocol DashboardLandingPresenterToView: AnyObject {
    var presenter: DashboardLandingViewToPresenter? { get set }
    
    func reloadView()
    func showLoader(_ isShowing: Bool)
    func showAlert(titleStr: String?, messageStr: String?, actionTitles:[String?])
}

// MARK: Interactor -
protocol DashboardLandingPresenterToInteractor: AnyObject {
    var presenter: DashboardLandingInteractorToPresenter? { get set }
    var worker: WorkerProtocol? { get set }
    
    func getMovieList()
}

// MARK: Router -
protocol DashboardLandingPresenterToRouter: AnyObject {
    func navigateToFavourites(from view: DashboardLandingPresenterToView?)
    func navigateToMovieDetail(from view: DashboardLandingPresenterToView?, movieDetails: MovieList?)
}

// MARK: Presenter -
protocol DashboardLandingViewToPresenter: AnyObject {
    var view: DashboardLandingPresenterToView? { get set }
    var interactor: DashboardLandingPresenterToInteractor? { get set }
    var router: DashboardLandingPresenterToRouter? { get set }
    
    func viewDidload()
    func getSearch(text: String)
    func numberOfSections() -> Int
    func viewForHeader(in section: Int) -> HomeSectionCellViewModelProtocol?
    func numberOfRows(in section: Int) -> Int
    func model(for index: IndexPath) -> MovieCellViewModelProtocol?
    func selectedModel(for index: IndexPath)
    func markFavourite(for index: IndexPath)
    func showFavouriteMovieList()
}

protocol DashboardLandingInteractorToPresenter: AnyObject {
    func didSuccessMovieList(response: MovieListModel)
    func didFailedMovieList(with error: ErrorResponse?)
}
