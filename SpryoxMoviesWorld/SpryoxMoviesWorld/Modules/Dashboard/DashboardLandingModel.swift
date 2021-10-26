import UIKit


struct DashboardCellViewModel: MovieCellViewModelProtocol {
    var moviePosterImageURL: URL?
    var movieFavourableImage: UIImage?
    var movieNameString: String
    var movieDescriptionString: String
    var movieReleasedDateString: String
    var movieRatingsString: String
    
    init(movie: MovieList?) {
        if let movieURL = movie?.movieBanner {
            self.moviePosterImageURL = URL(string: movieURL)
        }
        print(movie?.isFavourite, "----")
        
        self.movieFavourableImage = UIImage(systemName: movie?.isFavourite ?? false ? "heart.fill" : "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .large)) 
        self.movieNameString = movie?.name ?? ""
        self.movieDescriptionString = movie?.movieListDescription ?? ""
        self.movieReleasedDateString = "Released On: " + (movie?.releaseYear?.getformattedDate() ?? "")
        self.movieRatingsString = "Rating: " + (movie?.ratings ?? "")
    }
}



struct DashboardSectionCellViewModel: HomeSectionCellViewModelProtocol {
    var titleString: String
    
    init(movieDetails: MovieDetails?) {
        titleString = movieDetails?.movieCategory ?? ""
    }
}
