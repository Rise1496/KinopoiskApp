//
//  FilmsTableViewCell.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 09.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit
import Rswift

class FilmsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textAlignment = .left
            titleLabel.numberOfLines = 2
            titleLabel.font = R.font.segoeUISemiBold(size: 17.0)
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.textAlignment = .right
            scoreLabel.font = R.font.segoeUISemiBold(size: 17.0)
        }
    }
    
    @IBOutlet private weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.textAlignment = .left
            subtitleLabel.numberOfLines = 2
            subtitleLabel.font = R.font.segoeUI(size: 15.0)
            subtitleLabel.textColor = .gray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModel: FilmsCellViewModel) {
        titleLabel.text = viewModel.localized_name
        subtitleLabel.text = viewModel.name
        if let score = viewModel.rating {
            scoreLabel.configureScoreLabel(with: score)
        } else {
            scoreLabel.text = ""
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
