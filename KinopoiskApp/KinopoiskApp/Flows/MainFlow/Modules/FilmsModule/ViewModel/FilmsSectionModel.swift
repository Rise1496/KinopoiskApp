//
//  FilmsSectionModel.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 09.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation
import RxDataSources

enum FilmsSectionModel {
    case filmsItemSection(items: [FilmsSectionItem], year: Int)
}

extension FilmsSectionModel: SectionModelType {
    typealias Item = FilmsSectionItem
    
    var items: [Item] {
        switch self {
        case .filmsItemSection(let items, _):
            return items.map { $0 }
        }
    }
    
    init(original: FilmsSectionModel, items: [FilmsSectionItem]) {
        switch original {
        case .filmsItemSection(let items, let year):
            self = .filmsItemSection(items: items, year: year)
        }
    }
}

enum FilmsSectionItem {
    case filmItem(cellViewModel: FilmsCellViewModel)
}
