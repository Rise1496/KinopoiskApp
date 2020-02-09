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
    
    func makeFilmsRequest(failureBlock: @escaping StringAction) {
        let getFilmsRequest = getFilmsRequestObservable()
        getFilmsRequest.subscribe(onNext: { [weak self] (result) in
            switch result {
            case .success(let films):
                self?.configureSections(films: films)
            case .failed(let message):
                failureBlock(message)
            }
        }, onError: { error in
            failureBlock(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    private func configureSections(films: [FilmModel]) {
        var items = [FilmsSectionItem]()
        for film in films {
            items.append(FilmsSectionItem.filmItem(cellViewModel:
                FilmsCellViewModel(localized_name: film.localized_name,
                                   name: film.name, year: film.year,
                                   rating: film.rating)))
        }
        sections.accept([FilmsSectionModel.filmsItemSection(items: items)])
    }
}

extension FilmsViewModel {
    private func getFilmsRequestObservable() -> Observable<GetFilmsRequestResult> {
        return provider.rx.request(.getFilms).map(GetFilmsResponseModel.self).map { model in
            return GetFilmsRequestResult.success(films: model.films)
            }.catchErrorJustReturn(GetFilmsRequestResult.failed(message:
                .defaultErrorString)).asObservable()
    }
}
