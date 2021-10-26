
import UIKit
import MapKit

struct MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var region: MKCoordinateRegion
    var annotationArray: [MKPointAnnotation]
    var movieImageURL: URL?
    var movieTitleString: String?
    var releaseDateString: String?
    var ratingString: String?
    var descriptionString: String?
    var location: CLLocationCoordinate2D

    init(details: MovieList?) {
        let locationCoordinate = CLLocationCoordinate2D(latitude: Double(details?.theatreLocations?.first?.latitude ?? "0.0") ?? 0.0, longitude: Double(details?.theatreLocations?.first?.longitude ?? "0.0") ?? 0.0)
        var annotations: [MKPointAnnotation] = []
        for item in details?.theatreLocations ?? [] {
            let coordinate = CLLocationCoordinate2D(latitude: Double(item.latitude ?? "0.0") ?? 0.0, longitude: Double(item.longitude ?? "0.0") ?? 0.0)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }

        if let movieURL = details?.movieBanner {
            self.movieImageURL = URL(string: movieURL)
        }
        
        self.movieTitleString = details?.name ?? ""
        self.releaseDateString = "Released On: " + (details?.releaseYear?.getformattedDate() ?? "")
        self.ratingString = "Rating: " + (details?.ratings ?? "")
        self.descriptionString = details?.movieListDescription ?? ""
        self.annotationArray = annotations
        self.location = locationCoordinate
        self.region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: 200, longitudinalMeters: 200)

    }
}
