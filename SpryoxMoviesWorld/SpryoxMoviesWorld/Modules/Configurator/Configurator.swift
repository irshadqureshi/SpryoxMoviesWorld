//
//  Configurator.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit

public class Configurator {
    public static var shared = Configurator()

     public func createDashboardLandingModule() -> UIViewController {
         let worker:WorkerProtocol = Worker()
         let view: UIViewController & DashboardLandingPresenterToView = DashboardLandingView()
         let presenter: DashboardLandingViewToPresenter & DashboardLandingInteractorToPresenter = DashboardLandingPresenter()
         let interactor: DashboardLandingPresenterToInteractor = DashboardLandingInteractor()
         let router: DashboardLandingPresenterToRouter = DashboardLandingRouter()
        
         view.presenter = presenter
         presenter.view = view
         presenter.router = router
         presenter.interactor = interactor
         interactor.presenter = presenter
         interactor.worker = worker

         return view
     }
    
    public func createFavouriteListView() -> UIViewController {
        let view: UIViewController & FavouritesPresenterToView = FavouritesView()
        let presenter: FavouritesViewToPresenter & FavouritesInteractorToPresenter = FavouritesPresenter()
        let interactor: FavouritesPresenterToInteractor = FavouritesInteractor()
        let router: FavouritesPresenterToRouter = FavouritesRouter()
       
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }

    public func createMovieDetailsView(movieDetails: MovieList?) -> UIViewController {
        let view: UIViewController & MovieDetailsPresenterToView = MovieDetailsView()
        let presenter: MovieDetailsViewToPresenter & MovieDetailsInteractorToPresenter = MovieDetailsPresenter()
        let interactor: MovieDetailsPresenterToInteractor = MovieDetailsInteractor()
        let router: MovieDetailsPresenterToRouter = MovieDetailsRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.movieDetails = movieDetails
        interactor.presenter = presenter

        return view
    }
}
