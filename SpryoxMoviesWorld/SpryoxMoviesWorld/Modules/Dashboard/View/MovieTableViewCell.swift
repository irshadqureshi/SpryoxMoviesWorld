//
//  MovieTableViewCell.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import UIKit
import Kingfisher

protocol MovieCellViewModelProtocol {
    var moviePosterImageURL: URL? {get set}
    var movieFavourableImage: UIImage? {get set}
    var movieNameString: String {get set}
    var movieDescriptionString: String {get set}
    var movieReleasedDateString: String {get set}
    var movieRatingsString: String {get set}
}

class MovieTableViewCell: UITableViewCell {
    
    var favouriteCallback: (() -> Void)?

 
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieFavourableImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieReleasedDateLabel: UILabel!
    @IBOutlet weak var movieRatingsLabel: UILabel!
    @IBOutlet weak var movieFavourableButton: UIButton!

    var imageURL: URL? {
        didSet {
            self.moviePosterImage.kf.setImage(with: imageURL, placeholder: UIImage(named: Constants.ImageName.placeholder))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
        favouriteCallback?()
    }
    
    func bind(from viewModel: MovieCellViewModelProtocol) {
        imageURL = viewModel.moviePosterImageURL
        movieFavourableImage.image = viewModel.movieFavourableImage
        movieNameLabel.text = viewModel.movieNameString
        movieDescriptionLabel.text = viewModel.movieDescriptionString
        movieReleasedDateLabel.text = viewModel.movieReleasedDateString
        movieRatingsLabel.text = viewModel.movieRatingsString
    }
}
