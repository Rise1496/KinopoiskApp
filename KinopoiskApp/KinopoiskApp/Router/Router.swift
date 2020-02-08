//
//  Router.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit

final class Router: NSObject, Routerable {
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]

    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }

    func toPresent() -> UIViewController? {
        return rootController
    }

    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }

    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: Action?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    func push(_ module: Presentable?) {
        push(module, animated: true)
    }

    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?, animated: Bool, completion: Action?) {
        guard
            let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }

        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }

    func popModule() {
        popModule(animated: true)
    }

    func popModule(animated: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func popModule(to module: Presentable?) {
        popModule(to: module, animated: true)
    }
    
    func popModule(to module: Presentable?, animated: Bool) {
        if let correctModule = module as? UIViewController,
            let controllers = rootController?.popToViewController(correctModule, animated: animated) {
            _ = controllers.compactMap({ runCompletion(for: $0) })
        }
    }

    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
    }

    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    func changeInteractivePopGesture(value: Bool) {
        rootController?.interactivePopGestureRecognizer?.isEnabled = value
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
}
