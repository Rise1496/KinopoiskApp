//
//  CoordinatorFactory.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation
import Moya

final class CoordinatorFactory: CoordinatorFactoring {
    func makeMainCoordinator(factory: MainModuleFactoring,
                             router: Routerable,
                             provider: MoyaProvider<APIProvider>) -> MainCoordinator {
        return MainCoordinator(factory: factory, router: router,
                               provider: provider)
    }
}
