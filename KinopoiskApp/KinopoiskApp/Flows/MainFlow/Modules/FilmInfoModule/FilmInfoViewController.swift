//
//  FilmInfoViewController.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 09.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit
import Rswift

class FilmInfoViewController: BaseTableViewController, FilmInfoViewInput, FilmInfoViewOutput {
    
    // MARK: - FilmInfoViewInput
    var viewModel: FilmInfoViewModel!
    
    // MARK: - Lifecycle
    override func setupUI() {
        title = viewModel.getTitle()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.refreshControl = nil
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: R.nib.filmInfoTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: R.nib.filmInfoTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource
extension FilmInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            R.nib.filmInfoTableViewCell.identifier, for: indexPath)
            as? FilmInfoTableViewCell else {
                fatalError("Cell is not of kind \(FilmInfoTableViewCell.nameOfClass)")
        }
        cell.configure(with: viewModel.makeCellViewModel())
        return cell
    }
}
