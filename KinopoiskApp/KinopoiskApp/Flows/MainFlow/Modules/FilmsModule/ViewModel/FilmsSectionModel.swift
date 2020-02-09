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
    case filmsItemSection(items: [FilmsSectionItem])
}

extension FilmsSectionModel: SectionModelType {
    typealias Item = FilmsSectionItem
    
    var items: [Item] {
        switch self {
        case .filmsItemSection(let items):
            return items.map { $0 }
        }
    }
    
    init(original: FilmsSectionModel, items: [FilmsSectionItem]) {
        switch original {
        case .filmsItemSection(let items):
            self = .filmsItemSection(items: items)
        }
    }
}

enum FilmsSectionItem {
    case filmItem(cellViewModel: FilmsCellViewModel)
}
