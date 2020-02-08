//
//  Coordinatable.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation

protocol Coordinatable: class {
    var finishFlow: Action? { get set }
    func start()
}
