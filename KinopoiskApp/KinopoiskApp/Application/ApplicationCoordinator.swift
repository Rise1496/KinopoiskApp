//
//  ApplicationCoordinator.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactoring
    private let router: Routerable
    
    init(router: Routerable, coordinatorFactory: CoordinatorFactoring) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runMainFlow()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinator(factory: MainModuleFactory(), router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
