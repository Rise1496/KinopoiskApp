//
//  ApplicationCoordinator.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation
import Moya

final class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactoring
    private let router: Routerable
    private let provider: MoyaProvider<APIProvider>
    
    init(router: Routerable,
         coordinatorFactory: CoordinatorFactoring,
         provider: MoyaProvider<APIProvider>) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
    }
    
    override func start() {
        runMainFlow()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinator(factory: MainModuleFactory(), router: router, provider: provider)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
