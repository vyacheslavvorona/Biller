//
//  FriendsViewController.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public protocol FriendsViewModelProtocol: class {
    
}

public class FriendsViewController: UIViewController {
    private lazy var viewModel: FriendsViewModelProtocol = FriendsViewModel()
    
    
}
