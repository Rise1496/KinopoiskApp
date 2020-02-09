//
//  FilmInfoViewModel.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 09.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

class FilmInfoViewModel {
    let film: FilmModel
    
    init(film: FilmModel) {
        self.film = film
    }
    
    func getTitle() -> String {
        return film.localized_name
    }
    
    func makeCellViewModel() -> FilmInfoCellViewModel {
        return FilmInfoCellViewModel(film: film)
    }
}
