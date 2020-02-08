//
//  Routerable.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

protocol Routerable: Presentable {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: Action?)

    func popModule()
    func popModule(animated: Bool)
    func popModule(to module: Presentable?)
    func popModule(to module: Presentable?, animated: Bool)

    func dismissModule()
    func dismissModule(animated: Bool, completion: Action?)

    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)

    func popToRootModule(animated: Bool)
    
    func changeInteractivePopGesture(value: Bool)
}
