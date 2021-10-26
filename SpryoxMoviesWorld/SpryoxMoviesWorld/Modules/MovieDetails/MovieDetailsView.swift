//
//  MovieDetailsView.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit
import MapKit
import Kingfisher

class MovieDetailsView: BaseViewController, MovieDetailsPresenterToView {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var theatreMapView: MKMapView!
    var imageURL: URL? {
        didSet {
            self.moviePosterImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: Constants.ImageName.placeholder))
        }
    }
    var presenter: MovieDetailsViewToPresenter?

    init() {
        super.init(nibName: String(describing: MovieDetailsView.self), bundle: Bundle(for: MovieDetailsView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func populateDetails(from viewModel: MovieDetailsViewModelProtocol) {
        imageURL = viewModel.movieImageURL
        movieTitleLabel.text = viewModel.movieTitleString
        releaseDateLabel.text = viewModel.releaseDateString
        ratingLabel.text = viewModel.ratingString
        descriptionLabel.text = viewModel.descriptionString
        setupMapView(from: viewModel)
    }
    
    func setupMapView(from viewModel: MovieDetailsViewModelProtocol) {
        theatreMapView.delegate = self
        theatreMapView.setRegion(viewModel.region, animated: false)
        for point in viewModel.annotationArray {
            theatreMapView.addAnnotation(point)
        }
        theatreMapView.showAnnotations(viewModel.annotationArray, animated: true)
//        theatreMapView.setCenter(viewModel.location, animated: false)
    }
    
}

extension MovieDetailsView: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            } else {
                annotationView!.annotation = annotation
            }

            return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotation = views.first(where: { $0.reuseIdentifier == "AnnotId" })?.annotation {
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.calloutTapped(_:)))
//        view.addGestureRecognizer(gesture)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("calloutAccessoryControlTapped")
     }

//    @objc func calloutTapped(_ sender:UITapGestureRecognizer) {
//        let encoded = venueModel.venue_title.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
//        guard let url = URL(string:"maps://?q=\(encoded)&ll=\(venueModel.location_lat),\(venueModel.location_lng)") else { return }
//        if UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url)
//        }
//    }
}
