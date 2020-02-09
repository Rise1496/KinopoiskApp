//
//  MainModuleFactory.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

class MainModuleFactory: MainModuleFactoring {
    func makeFilmsModule() -> FilmsViewOutput & FilmsViewInput {
        return FilmsViewController()
    }
    
    func makeFilmInfoModule() -> FilmInfoViewInput & FilmInfoViewOutput {
        return FilmInfoViewController()
    }
}
