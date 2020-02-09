//
//  FilmsViewOutput.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

protocol FilmsViewOutput: BaseView {
    var onFilm: FilmAction? { get set }
}
