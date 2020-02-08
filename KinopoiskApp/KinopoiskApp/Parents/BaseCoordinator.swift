//
//  BaseCoordinator.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation
import RxSwift

class BaseCoordinator: Coordinatable {
    var childCoordinators: [Coordinatable] = []
    
    // MARK: - Coordinatable
    
    var finishFlow: Action?
    func start() {}

    /// Utility `DisposeBag` used by the subclasses.
    let disposeBag = DisposeBag()

    deinit {
        print("\(NSStringFromClass(type(of: self)).components(separatedBy: ".").last!) deinit")
    }
    
    // add only unique object
    func addDependency(_ coordinator: Coordinatable) {
        for element in childCoordinators where element === coordinator {
             return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinatable?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
                childCoordinators.remove(at: index)
                break
        }
    }
}
