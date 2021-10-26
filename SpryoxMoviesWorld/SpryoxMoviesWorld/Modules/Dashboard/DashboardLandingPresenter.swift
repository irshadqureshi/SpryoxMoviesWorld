//
//  DashboardLandingPresenter.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation
import CoreData
import Reachability

class DashboardLandingPresenter: DashboardLandingViewToPresenter {
    weak var view: DashboardLandingPresenterToView?
    var interactor: DashboardLandingPresenterToInteractor?
    var router: DashboardLandingPresenterToRouter?
    
    var sectionCellViewModel: DashboardSectionCellViewModel?
    var cellViewModel: DashboardCellViewModel?
    var movies: MovieListModel?
    var searchedMovie: MovieListModel?
    var inSearchMode: Bool = false
    let reachability = try! Reachability()
    
     deinit {
        reachability.stopNotifier()
     }
     
    func viewDidload() {
        reachability.whenReachable = { [weak self] reachability in
            if let model = DatabaseManager.sharedInstance.retrieveMovieData() {
                self?.movies = model
                self?.searchedMovie = model
                self?.view?.reloadView()
            } else {
                self?.interactor?.getMovieList()
            }
        }
        reachability.whenUnreachable = { [weak self] _ in
            self?.view?.showAlert(titleStr: "Alert", messageStr: "Please check your internet connection and try again", actionTitles: ["OK"])
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
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
        let model = DatabaseManager.sharedInstance.retrieveMovieData()
        self.movies = model
        self.searchedMovie = model
        self.view?.reloadView()
    }
    
    func getSearchBarStatus(text: String) {
        inSearchMode = !(text == "")
        print(inSearchMode)
    }
    
    func getSearch(text: String){
        getSearchBarStatus(text: text)

        var details:[MovieDetails] = []
        guard let moviesData = self.movies?.data else {return}
        for movie in moviesData {

            var list:[MovieList] = []

            for item in movie.movieList ?? [] {
                if let name = item.name?.lowercased(), name.contains(text.lowercased()) {
                    list.append(item)
                }
            }
            if list.count != 0 {
                let movieDetail = MovieDetails(movieCategory: movie.movieCategory, movieCategoryCode: movie.movieCategoryCode, movieList: list)
                details.append(movieDetail)
            }
        }
        searchedMovie = nil
        searchedMovie = MovieListModel(success: self.searchedMovie?.success, message: self.searchedMovie?.message, data: details)
        view?.reloadView()
    }
    
    func showFavouriteMovieList(){
        router?.navigateToFavourites(from: self.view)
    }
}

typealias DashboardTableDataSource = DashboardLandingPresenter
extension DashboardTableDataSource {
    func numberOfSections() -> Int {
        inSearchMode ? self.searchedMovie?.data?.count ?? 0 : self.movies?.data?.count ?? 0
    }
    
    func numberOfRows(in section: Int) -> Int {
        inSearchMode ? self.searchedMovie?.data?[section].movieList?.count ?? 0 : self.movies?.data?[section].movieList?.count ?? 0
    }
    
    func viewForHeader(in section: Int) -> HomeSectionCellViewModelProtocol? {
        sectionCellViewModel = DashboardSectionCellViewModel(movieDetails: inSearchMode ? self.searchedMovie?.data?[section] : self.movies?.data?[section])
        return sectionCellViewModel
    }
    
    func model(for index: IndexPath) -> MovieCellViewModelProtocol? {
        cellViewModel = DashboardCellViewModel(movie: inSearchMode ? self.searchedMovie?.data?[index.section].movieList?[index.row] : self.movies?.data?[index.section].movieList?[index.row])
        return cellViewModel
    }
    
}

typealias DashboardTableDelegate = DashboardLandingPresenter
extension DashboardTableDelegate {
    func markFavourite(for index: IndexPath) {
        let movie = inSearchMode ? self.searchedMovie?.data?[index.section].movieList?[index.row] : self.movies?.data?[index.section].movieList?[index.row]
        addMovieToFavourite(name: movie?.name ?? "", isFavourite: movie?.isFavourite ?? false)
    }
 
    func selectedModel(for index: IndexPath) {
        router?.navigateToMovieDetail(from: self.view, movieDetails: inSearchMode ? self.searchedMovie?.data?[index.section].movieList?[index.row] : self.movies?.data?[index.section].movieList?[index.row])
    }
}

extension DashboardLandingPresenter: DashboardLandingInteractorToPresenter {
    func didSuccessMovieList(response: MovieListModel) {
        if DatabaseManager.sharedInstance.saveDataIntoLocalDataBase(responseData: response) {
            let model = DatabaseManager.sharedInstance.retrieveMovieData()
            self.movies = model
            self.searchedMovie = model
            self.view?.reloadView()
        } else {
            self.movies = response
            self.searchedMovie = response
            self.view?.reloadView()
        }
    }
    
    func didFailedMovieList(with error: ErrorResponse?) {
        self.view?.showAlert(titleStr: "Alert", messageStr: error?.info, actionTitles: ["OK"])
    }
}
