//
//  FilmsViewController.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import Rswift

class FilmsViewController: BaseTableViewController, FilmsViewInput, FilmsViewOutput {
    // MARK: - FilmsViewInput
    var viewModel: FilmsViewModel!
    
    // MARK: - FilmsViewOutput
    var onFilm: FilmAction?
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.makeFilmsRequest(completionBlock: nil, failureBlock: { [weak self] (message) in
            self?.showErrorAlertWith(message)
        })
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: R.nib.filmsTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: R.nib.filmsTableViewCell.identifier)
    }
    
    override func setupBindings() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.sections
            .bind(to: tableView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(FilmsSectionItem.self).subscribe ({ [weak self] (item) in
            guard let cellVM = item.element else {
                return
            }
            switch cellVM {
            case .filmItem(let cellViewModel):
                self?.onFilm?(cellViewModel.film)
            }
        }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func setupUI() {
        title = "Films.Controller.Title".localized
    }
    
    override func refresh() {
        viewModel.makeFilmsRequest(completionBlock: { [weak self] in
            self?.refreshControl.endRefreshing()
        }, failureBlock: { [weak self] (message) in
            self?.refreshControl.endRefreshing()
            self?.showErrorAlertWith(message)
        })
    }
    
    private func dataSource() -> RxTableViewSectionedReloadDataSource<FilmsSectionModel> {
        return RxTableViewSectionedReloadDataSource<FilmsSectionModel>(configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
            switch item {
            case .filmItem(let cellViewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.filmsTableViewCell.identifier, for: indexPath)
                    as? FilmsTableViewCell else {
                        fatalError("Cell is not of kind \(FilmsTableViewCell.nameOfClass)")
                }
                cell.configure(with: cellViewModel)
                return cell
            }
        })
    }
}

// MARK: - UITableViewDelegate
extension FilmsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.applyFilmsSectionDesign(title: viewModel.getSectionTitle(sectionIndex: section))
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
}
