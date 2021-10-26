//
//  DatabaseManager.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit
import CoreData

class DatabaseManager: NSObject {
    
    static let sharedInstance = DatabaseManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let modelURL = Bundle.main.url(forResource: "SpryoxMoviesWorld", withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL!)
        let container = NSPersistentContainer(name: "SpryoxMoviesWorld", managedObjectModel: managedObjectModel!)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Save data into local database
    func saveDataIntoLocalDataBase(responseData: MovieListModel) -> Bool {
        guard let movieDetails = responseData.data else { return false }
        
        if self.checkRowExistInLocalCache() {
            let _ = self.deleteRowByendPoint()
        }
        
        let managedContext = persistentContainer.viewContext
        
        for category in movieDetails {
            let fetchR = NSFetchRequest<Category>(entityName: "Category") as? Category
            if fetchR?.categoryName == category.movieCategory {
                return false
            }
            let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)!
            let localCategory = NSManagedObject(entity: categoryEntity, insertInto: managedContext)
            
            localCategory.setValue(category.movieCategory, forKey: "categoryName")
            localCategory.setValue(category.movieCategoryCode, forKey: "categoryCode")
            
            guard let list = category.movieList else {break}
            for movie in list {
                let localMovie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: managedContext)
                
                localMovie.setValue(movie.name, forKey: "name")
                localMovie.setValue(movie.movieListDescription, forKey: "movieListDescription")
                localMovie.setValue(false, forKey: "isFavourite")
                localMovie.setValue(movie.releaseYear, forKey: "releaseYear")
                localMovie.setValue(movie.movieBanner, forKey: "movieBanner")
                localMovie.setValue(movie.movieIcon, forKey: "movieIcon")
                localMovie.setValue(movie.ratings, forKey: "ratings")
                
                localCategory.mutableSetValue(forKey: "movie").add(localMovie)
                
                guard let theater = movie.theatreLocations else {break}
                for location in theater {
                    
                    let localLocation = NSEntityDescription.insertNewObject(forEntityName: "Location", into: managedContext)
                    
                    localLocation.setValue(location.longitude, forKey: "longitude")
                    localLocation.setValue(location.latitude, forKey: "latitude")
                    
                    localMovie.mutableSetValue(forKey: "location").add(localLocation)
                }
            }
        }
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    
    // MARK: - RETRIEVE MOVIE DATA
    
    func retrieveMovieData() -> MovieListModel? {
        
        var details: [MovieDetails] = []
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            let categoryList = try managedContext.fetch(fetchRequest)
            print(categoryList)
            for category in categoryList {
                var list:[MovieList] = []
                
                guard let movie = category.movie else {return nil}
                for case let currentMovie as Movie in movie  {
                    var location: [TheatreLocation] = []
                    
                    guard let theaterLocation = currentMovie.location else {return nil}
                    for case let currentLocation as Location in theaterLocation  {
                        
                        let latlong = TheatreLocation(latitude: currentLocation.latitude,
                                                      longitude:  currentLocation.longitude)
                        location.append(latlong)
                        
                    }
                    
                    let movie = MovieList(isFavourite: currentMovie.isFavourite,
                                          name:  currentMovie.name,
                                          movieListDescription:  currentMovie.movieListDescription,
                                          releaseYear:  currentMovie.releaseYear,
                                          movieBanner:  currentMovie.movieBanner,
                                          movieIcon:  currentMovie.movieIcon,
                                          ratings:  currentMovie.ratings,
                                          theatreLocations: location)
                    
                    list.append(movie)
                }
                let movieCategory = MovieDetails(movieCategory: category.categoryName,
                                                 movieCategoryCode: category.categoryCode,
                                                 movieList: list)
                details.append(movieCategory)
            }
            
            return details.count != 0 ? MovieListModel(success: true, message: "success", data: details) : nil
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    func retrieveFavouriteMovieList() -> MovieListModel? {
        
        var details: [MovieDetails] = []
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            let categoryList = try managedContext.fetch(fetchRequest)
            print(categoryList)
            for category in categoryList {
                var list:[MovieList] = []
                
                guard let movie = category.movie else {return nil}
                for case let currentMovie as Movie in movie  {
                    var location: [TheatreLocation] = []
                    
                    guard let theaterLocation = currentMovie.location else {return nil}
                    for case let currentLocation as Location in theaterLocation  {
                        
                        let latlong = TheatreLocation(latitude: currentLocation.latitude,
                                                      longitude:  currentLocation.longitude)
                        location.append(latlong)
                        
                    }
                    
                    let movie = MovieList(isFavourite: currentMovie.isFavourite,
                                          name:  currentMovie.name,
                                          movieListDescription:  currentMovie.movieListDescription,
                                          releaseYear:  currentMovie.releaseYear,
                                          movieBanner:  currentMovie.movieBanner,
                                          movieIcon:  currentMovie.movieIcon,
                                          ratings:  currentMovie.ratings,
                                          theatreLocations: location)
                    if currentMovie.isFavourite {
                        list.append(movie)
                    }
                }
                let movieCategory = MovieDetails(movieCategory: category.categoryName,
                                                 movieCategoryCode: category.categoryCode,
                                                 movieList: list)
                if list.count != 0 {
                    details.append(movieCategory)
                }
            }
            
            return details.count != 0 ? MovieListModel(success: true, message: "success", data: details) : nil
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    // MARK: - Check row exisit in local cache
    func checkRowExistInLocalCache() -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        fetchRequest.includesSubentities = true
        let managedContext = persistentContainer.viewContext
        var entitiesCount = 0
        do {
            entitiesCount = try managedContext.count(for: fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        return entitiesCount > 0
    }
    
    // MARK: - Delete row by primary name
    func deleteRowByendPoint() -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
        let managedContext = persistentContainer.viewContext
        do {
            let getResult = try managedContext.fetch(fetchRequest)
            for object in getResult {
                managedContext.delete(object)
                return true
            }
            
        } catch let error as NSError {
            print("Could not fetch - \(error), \(error.userInfo)")
        }
        return false
    }
    
}
