//
//  HistoryViewController.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public protocol HistoryViewModelProtocol {
    
}

public class HistoryViewController: UIViewController {
    private lazy var viewModel: HistoryViewModelProtocol = HistoryViewModel()
    
    
}
