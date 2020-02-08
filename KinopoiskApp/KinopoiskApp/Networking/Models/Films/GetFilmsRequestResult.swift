//
//  GetFilmsRequestResult.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 09.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

enum GetFilmsRequestResult {
    case success(films: [FilmModel])
    case failed(message: String)
}
