//
//  MovieTableCell.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 02/01/24.
//

import UIKit
import MoviesUIKit

class MovieTableCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet private weak var movieNameLabel: CommonAppLabel! {
        didSet {
            movieNameLabel.style = .title1
        }
    }
    @IBOutlet private weak var movieSummaryLabel: CommonAppLabel! {
        didSet {
            movieSummaryLabel.style = .subHeader
        }
    }
    @IBOutlet private weak var ratingLabel: CommonAppLabel! {
        didSet {
            ratingLabel.style = .cellLabel
            ratingLabel.textColor = .systemGray
        }
    }
    @IBOutlet private weak var releaseDateLabel: CommonAppLabel! {
        didSet {
            releaseDateLabel.style = .cellLabel
            releaseDateLabel.textColor = .systemGray
        }
    }
    @IBOutlet private weak var movieThumbnailImage: UIImageView!

    private var cellIndexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        backGroundView.backgroundColor = .secondarySystemGroupedBackground
    }
    
    /// This 'ConfigCell' function set the table cell content from the provided data model
    /// - Parameters:
    ///   - movieData: movie data model
    ///   - indexPath: indexpath of the table cell
    func configCell(movieData: MovieDataModel, indexPath: IndexPath) {
        cellIndexPath = indexPath
        movieNameLabel.text = movieData.title
        movieSummaryLabel.text = movieData.description
        ratingLabel.text = movieData.rating
        releaseDateLabel.text = "\(movieData.year ?? 0)"
        movieThumbnailImage.setImage(with: movieData.image ?? "")
        
        // Setting the labels accessibilities
        ratingLabel.accessibilityValue =  MovieStrings.imdbRating
        releaseDateLabel.accessibilityValue = MovieStrings.releaseYear
        
        // Setting the accessibility identifiers
        movieNameLabel.accessibilityIdentifier = MoviesConstants.AccessibilityIdentifiers.movieNameLabel + "\(indexPath.row)"
        movieSummaryLabel.accessibilityIdentifier = MoviesConstants.AccessibilityIdentifiers.movieSummaryLabel + "\(indexPath.row)"
        ratingLabel.accessibilityIdentifier = MoviesConstants.AccessibilityIdentifiers.ratingLabel + "\(indexPath.row)"
        releaseDateLabel.accessibilityIdentifier = MoviesConstants.AccessibilityIdentifiers.releaseDateLabel + "\(indexPath.row)"
        movieThumbnailImage.accessibilityIdentifier = MoviesConstants.AccessibilityIdentifiers.movieThumbnailImage + "\(indexPath.row)"
        self.accessibilityElements = [movieNameLabel as Any, movieSummaryLabel as Any, ratingLabel as Any, releaseDateLabel as Any]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
