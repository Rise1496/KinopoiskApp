//
//  FilmsViewController.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit

class FilmsViewController: BaseTableViewController, FilmsViewInput, FilmsViewOutput {
    // MARK: - FilmsViewInput
    var viewModel: FilmsViewModel!
    
    // MARK: - FilmsViewOutput
    var onFilm: Action?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.makeFilmsRequest { [weak self] (message) in
            self?.showErrorAlertWith(message)
        }
    }
}
