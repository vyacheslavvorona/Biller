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
    func setViewController(_ viewController: PlaceViewControllerProtocol)
}

fileprivate struct CellIdentifiers {
    static let placeTitleCell = "PlaceTitleCell"
    static let ratingCell = "RatingCell"
    static let goToCell = "GoToCell"

}

public class PlaceViewController: UIViewController, PlaceViewControllerProtocol {
    
    public var viewModel: PlaceViewModelProtocol? {
        didSet {
            viewModel?.setViewController(self)
        }
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: CellIdentifiers.placeTitleCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.placeTitleCell)
            tableView.register(UINib(nibName: CellIdentifiers.ratingCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.ratingCell)
            tableView.register(UINib(nibName: CellIdentifiers.goToCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.goToCell)
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 100
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

extension PlaceViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension PlaceViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        case 1, 2 :
            return 50
        default:
            return UITableViewAutomaticDimension
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, let titleCell = makePlaceTitleCell() {
            return titleCell
        } else if indexPath.row == 1, let ratingCell = makeRatingCell() {
            return ratingCell
        } else if indexPath.row == 2, let menuCell = makeGoToMenuCell() {
            return menuCell
        }
        return UITableViewCell()
    }

    private func makePlaceTitleCell() -> PlaceTitleCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.placeTitleCell) as? PlaceTitleCell else {
            return nil
        }

        //add some setup
        return cell
    }

    private func makeRatingCell() -> RatingCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.ratingCell) as? RatingCell else {
            return nil
        }

        return cell
    }

    private func makeGoToMenuCell() -> GoToCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.goToCell) as? GoToCell else {
            return nil
        }

        cell.goToLabel.text = "Menu"
        return cell
    }
}
