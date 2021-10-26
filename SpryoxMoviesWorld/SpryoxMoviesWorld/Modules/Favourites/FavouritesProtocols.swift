// 
//  FavouritesProtocols.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit

// MARK: View -
protocol FavouritesPresenterToView: class {
    var presenter: FavouritesViewToPresenter? { get set }
    
    func reloadView()
}

// MARK: Interactor -
protocol FavouritesPresenterToInteractor: class {
    var presenter: FavouritesInteractorToPresenter? { get set }
}

// MARK: Router -
protocol FavouritesPresenterToRouter: class {
}

// MARK: Presenter -
protocol FavouritesViewToPresenter: class {
    var view: FavouritesPresenterToView? { get set }
    var interactor: FavouritesPresenterToInteractor? { get set }
    var router: FavouritesPresenterToRouter? { get set }
    
    func viewDidload()
    func numberOfSections() -> Int
    func viewForHeader(in section: Int) -> HomeSectionCellViewModelProtocol?
    func numberOfRows(in section: Int) -> Int
    func model(for index: IndexPath) -> MovieCellViewModelProtocol?
    func markFavourite(for index: IndexPath)
}

protocol FavouritesInteractorToPresenter: class {
}
