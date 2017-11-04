//
//  HistoryViewModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import RealmSwift
import Result

public protocol HistoryViewControllerProtocol {
    var billDisplayItems: [BillDisplayItem] { get set }
}

public class HistoryViewModel: HistoryViewModelProtocol {
    
    public var viewController: HistoryViewControllerProtocol?
    
    public convenience init(name: String?) {
        self.init()
    }
}