//
//  FilmInfoTableViewCell.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 09.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit
import Kingfisher
import Rswift

class FilmInfoTableViewCell: UITableViewCell {
    @IBOutlet private weak var filmImageView: UIImageView! {
        didSet {
            filmImageView.contentMode = .scaleAspectFit
            filmImageView.clipsToBounds = true
            filmImageView.kf.indicatorType = .activity
            let indicator: UIActivityIndicatorView = filmImageView.kf.indicator?.view as! UIActivityIndicatorView
            indicator.color = .white
            filmImageView.image = R.image.placeholderImage()
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .gray
            titleLabel.textAlignment = .left
            titleLabel.numberOfLines = 2
            titleLabel.font = R.font.segoeUI(size: 15.0)
        }
    }
    
    @IBOutlet private weak var yearLabel: UILabel! {
        didSet {
            yearLabel.textAlignment = .left
            yearLabel.font = R.font.segoeUI(size: 17.0)
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.textAlignment = .left
            scoreLabel.font = R.font.segoeUI(size: 17.0)
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = R.font.segoeUI(size: 17.0)
            descriptionLabel.numberOfLines = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with viewModel: FilmInfoCellViewModel) {
        titleLabel.text = viewModel.film.name
        yearLabel.text = "FilmInfo.Cell.Year".localized + String(viewModel.film.year)
        if let score = viewModel.film.rating {
            scoreLabel.configureScoreLabel(with: score,
                                           needsDescription: true)
        }
        descriptionLabel.text = viewModel.film.description ?? ""
        if let imageURL = viewModel.film.image_url {
            guard let url = URL(string: imageURL) else {
                return
            }
            filmImageView.kf.setImage(with: url, placeholder: R.image.placeholderImage(), options: [])
        } else {
            filmImageView.image = R.image.placeholderImage()
        }
    }
}
