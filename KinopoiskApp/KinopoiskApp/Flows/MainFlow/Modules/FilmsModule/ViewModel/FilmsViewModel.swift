//
//  FilmsViewModel.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation
import Moya

class FilmsViewModel {
    private let provider: MoyaProvider<APIProvider>
    
    init(provider: MoyaProvider<APIProvider>) {
        self.provider = provider
    }
}
