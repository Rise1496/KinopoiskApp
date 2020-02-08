//
//  MainCoordinator.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation
import Moya

class MainCoordinator: BaseCoordinator {
    private let factory: MainModuleFactoring
    private let router: Routerable
    private let provider: MoyaProvider<APIProvider>
    
    init(factory: MainModuleFactoring, router: Routerable,
         provider: MoyaProvider<APIProvider>) {
        self.factory = factory
        self.router = router
        self.provider = provider
    }
    
    override func start() {
        showFilmsModule()
    }
    
    private func showFilmsModule() {
        var filmsModule = factory.makeFilmsModule()
        filmsModule.viewModel = FilmsViewModel(provider: provider)
        router.setRootModule(filmsModule)
    }
}
