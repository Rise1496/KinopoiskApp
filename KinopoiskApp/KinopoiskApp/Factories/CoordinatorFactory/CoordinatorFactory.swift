//
//  CoordinatorFactory.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

final class CoordinatorFactory: CoordinatorFactoring {
    func makeMainCoordinator(factory: MainModuleFactoring,
                             router: Routerable) -> MainCoordinator {
        return MainCoordinator(factory: factory, router: router)
    }
}
