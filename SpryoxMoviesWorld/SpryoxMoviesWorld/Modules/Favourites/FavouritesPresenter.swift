//
//  FavouritesPresenter.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation
import CoreData

class FavouritesPresenter: FavouritesViewToPresenter {

    weak var view: FavouritesPresenterToView?
    var interactor: FavouritesPresenterToInteractor?
    var router: FavouritesPresenterToRouter?
    
    var sectionCellViewModel: DashboardSectionCellViewModel?
    var cellViewModel: DashboardCellViewModel?
    var movies: MovieListModel?
    
    func viewDidload() {
        if let model = DatabaseManager.sharedInstance.retrieveFavouriteMovieList() {
            self.movies = model
            self.view?.reloadView()
        }
    }
    
    private func addMovieToFavourite(name: String, isFavourite: Bool) {
        let managedContext = DatabaseManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "\(name)")
        fetchRequest.fetchBatchSize = 1
        fetchRequest.fetchLimit = 1

        do {
            let movieList = try managedContext.fetch(fetchRequest)
            if movieList.count != 0 {
                if let fetchedMovie = movieList[0] as? Movie {
                    fetchedMovie.isFavourite = !isFavourite
                }
            }
            try managedContext.save()
        } catch let error{
            print(error)
        }
        let model = DatabaseManager.sharedInstance.retrieveFavouriteMovieList()
        self.movies = model
        self.view?.reloadView()
    }
}


typealias FavouritesTableDataSource = FavouritesPresenter
extension FavouritesTableDataSource {
    func numberOfSections() -> Int {
        self.movies?.data?.count ?? 0
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.movies?.data?[section].movieList?.count ?? 0
    }
    
    func viewForHeader(in section: Int) -> HomeSectionCellViewModelProtocol? {
        sectionCellViewModel = DashboardSectionCellViewModel(movieDetails: self.movies?.data?[section])
        return sectionCellViewModel
    }
    
    func model(for index: IndexPath) -> MovieCellViewModelProtocol? {
        cellViewModel = DashboardCellViewModel(movie: self.movies?.data?[index.section].movieList?[index.row])
        return cellViewModel
    }
    
}

typealias FavouritesTableDelegate = FavouritesPresenter
extension FavouritesTableDelegate {
    func markFavourite(for index: IndexPath) {
        let movie = self.movies?.data?[index.section].movieList?[index.row]
        addMovieToFavourite(name: movie?.name ?? "", isFavourite: movie?.isFavourite ?? false)
    }
}

extension FavouritesPresenter: FavouritesInteractorToPresenter {
    
}
