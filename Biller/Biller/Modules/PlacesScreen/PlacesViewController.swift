//
//  PlacesViewController.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 11/4/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public protocol PlacesViewModelProtocol {
    var viewController: PlacesViewControllerProtocol? { get set }

}

public class PlacesViewController: UIViewController, PlacesViewControllerProtocol {
    private var viewModel: PlacesViewModelProtocol = PlacesViewModel() {
        didSet {
            viewModel.viewController = self
        }
    }
    public var placesDisplayItems: [PlaceDisplayItem] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "PlaceCell")
            tableView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
}

extension PlacesViewController: UITableViewDelegate {
    
}

extension PlacesViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesDisplayItems.count + 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= placesDisplayItems.count {
            return 70
        } else if indexPath.row < placesDisplayItems.count {
            return 160
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= placesDisplayItems.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell") as? AddCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as? BillCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}
