// 
//  DashboardLandingRouter.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit

class DashboardLandingRouter: DashboardLandingPresenterToRouter {

    // MARK: - Properties
    private let configurator: Configurator
    
    // MARK: - Init
    init(configurator: Configurator = .shared) {
        self.configurator = configurator
    }
  
    func navigateToMovieDetail(from view: DashboardLandingPresenterToView?, movieDetails: MovieList?) {
        DispatchQueue.main.async {
            if let dashboardView = view as? UIViewController {
                let movieDetailsView = self.configurator.createMovieDetailsView(movieDetails: movieDetails)
                dashboardView.navigationController?.pushViewController(movieDetailsView, animated: true)
            }
        }
    }
    
    func navigateToFavourites(from view: DashboardLandingPresenterToView?) {
        DispatchQueue.main.async {
            if let dashboardView = view as? UIViewController {
                let favouriteListView = self.configurator.createFavouriteListView()
                dashboardView.navigationController?.pushViewController(favouriteListView, animated: true)
            }
        }
    }

}
