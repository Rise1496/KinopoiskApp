//
//  FilmModel.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

struct FilmModel: Codable {
    let id: Int?
    let localized_name: String
    let name: String
    let year: Int
    let rating: Double?
    let image_url: String?
    let description: String?
    let genres: [String]?
}
