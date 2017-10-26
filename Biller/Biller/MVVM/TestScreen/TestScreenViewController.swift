//
//  TestScreenViewController.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/26/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public protocol TestScreenViewModelProtocol {
    
}

public class TestScreenViewController: UIViewController {
    private var viewModel: TestScreenViewModelProtocol = TestScreenViewModel()
    
    private var disposable = CompositeDisposable()
}
