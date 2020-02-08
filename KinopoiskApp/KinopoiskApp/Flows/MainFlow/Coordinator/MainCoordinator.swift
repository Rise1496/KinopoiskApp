//
//  MainCoordinator.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

class MainCoordinator: BaseCoordinator {
    private let factory: MainModuleFactoring
    private let router: Routerable
    
    init(factory: MainModuleFactoring, router: Routerable) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showFilmsModule()
    }
    
    private func showFilmsModule() {
        let filmsModule = factory.makeFilmsModule()
        router.setRootModule(filmsModule)
    }
}
