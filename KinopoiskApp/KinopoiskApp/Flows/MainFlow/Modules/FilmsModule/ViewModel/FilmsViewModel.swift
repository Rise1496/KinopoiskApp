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

class FilmsViewModel {
    private let provider: MoyaProvider<APIProvider>
    private let disposeBag = DisposeBag()
    
    init(provider: MoyaProvider<APIProvider>) {
        self.provider = provider
    }
    
    func makeFilmsRequest(failureBlock: @escaping StringAction) {
        let getFilmsRequest = getFilmsRequestObservable()
        getFilmsRequest.subscribe(onNext: { (result) in
            switch result {
            case .success(let films):
                print(films)
            case .failed(let message):
                failureBlock(message)
            }
        }, onError: { error in
            failureBlock(error.localizedDescription)
        }).disposed(by: disposeBag)
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
