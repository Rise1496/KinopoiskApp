//
//  BaseViewController.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    // MARK: - Properties

    // Utility `DisposeBag` used by the subclasses.

    let disposeBag = DisposeBag()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    deinit {
        print("\(self.nameOfClass) deinit")
    }
    
    // MARK: - Internal methodes
    
    func setupBindings() {
        
    }
}