//
//  PlaceViewController.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 11/4/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import UIKit

public protocol PlaceViewModelProtocol: class {
    var viewController: PlaceViewControllerProtocol? { get set }
}

public class PlaceViewController: UIViewController, PlaceViewControllerProtocol {
    
    var viewModel: PlaceViewModelProtocol? {
        didSet {
            viewModel?.viewController = self
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        viewModel = PlaceViewModel()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

    }
}
