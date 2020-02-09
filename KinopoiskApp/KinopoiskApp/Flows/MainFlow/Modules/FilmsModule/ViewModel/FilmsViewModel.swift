//
//  FilmsViewModel.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxDataSources
import RxCocoa

class FilmsViewModel {
    private let provider: MoyaProvider<APIProvider>
    private let disposeBag = DisposeBag()
    
    let sections = BehaviorRelay(value: [FilmsSectionModel]())
    
    init(provider: MoyaProvider<APIProvider>) {
        self.provider = provider
    }
    
    func makeFilmsRequest(completionBlock: Action?, failureBlock: @escaping StringAction) {
        let getFilmsRequest = getFilmsRequestObservable()
        getFilmsRequest.subscribe(onNext: { [weak self] (result) in
            switch result {
            case .success(let films):
                self?.configureSections(films: films)
                completionBlock?()
            case .failed(let message):
                failureBlock(message)
            }
        }, onError: { error in
            failureBlock(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func getSectionTitle(sectionIndex: Int) -> String {
        switch sections.value[sectionIndex] {
        case .filmsItemSection(_, let year):
            return String(year)
        }
    }
    
    private func configureSections(films: [FilmModel]) {
        var yearsSections = [FilmsSectionModel]()
        let groupedDictionary = Dictionary(grouping: films) { (film) -> Int in
            return film.year
        }
        let keys = groupedDictionary.keys.sorted()
        keys.forEach({
            var sectionItems = [FilmsSectionItem]()
            groupedDictionary[$0]?.forEach({ (film) in
                sectionItems.append(FilmsSectionItem.filmItem(cellViewModel:
                    FilmsCellViewModel(film: film)))
            })
            yearsSections.append(FilmsSectionModel.filmsItemSection(items: sectionItems,
                                                                    year: $0))
        })
        sections.accept(yearsSections)
    }
}

// MARK: - RequestObservable
extension FilmsViewModel {
    private func getFilmsRequestObservable() -> Observable<GetFilmsRequestResult> {
        return provider.rx.request(.getFilms).map(GetFilmsResponseModel.self).map { model in
            return GetFilmsRequestResult.success(films: model.films)
            }.catchErrorJustReturn(GetFilmsRequestResult.failed(message:
                .defaultErrorString)).asObservable()
    }
}
