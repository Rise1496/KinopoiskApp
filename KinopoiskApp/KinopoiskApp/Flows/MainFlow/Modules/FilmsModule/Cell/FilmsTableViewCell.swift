//
//  FilmsTableViewCell.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 09.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit

class FilmsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textAlignment = .left
//            titleLabel.font = R.
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            
        }
    }
    
    @IBOutlet private weak var subtitleLabel: UILabel! {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
