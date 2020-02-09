//
//  UILabelExtensions.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 09.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit
import Rswift

extension UILabel {
    func configureScoreLabel(with score: Double) {
        self.text = String(score)
        guard score >= 5.0 else {
            self.textColor = .lowScoreColor
            return
        }
        guard score >= 7.0 else {
            self.textColor = .middleScoreColor
            return
        }
        self.textColor = .highScoreColor
    }
    
    func applyFilmsSectionDesign(title: String) {
        self.text = title
        self.backgroundColor = .gray
        self.textAlignment = .center
    }
}
