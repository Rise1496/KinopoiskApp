//
//  BaseTableViewController.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit
import SnapKit

class BaseTableViewController: BaseViewController {
    // MARK: - Internal properties
    
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        setupTableView()
        setupPullToRefresh()
        registerCells()
    }
    
    // MARK: - Private methodes
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupPullToRefresh() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    // MARK: - Internal methodes
    
    func registerCells() {

    }
    
    @objc open func refresh() {

    }
    
}
