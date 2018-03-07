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

public protocol PlacesViewModelProtocol: class {
    var viewController: PlacesViewControllerProtocol? { get set }

    func displayItemsRequested()
    func createPlaceRequested()
    func showPlaceRequested(_ placeId: String)
}

public class PlacesViewController: UIViewController, PlacesViewControllerProtocol {

    private var viewModel: PlacesViewModelProtocol? {
        didSet {
            viewModel?.viewController = self
            viewModel?.displayItemsRequested()
        }
    }

    private var placesDisplayItems: [PlaceDisplayItem] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "PlaceCell")
            tableView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PlacesViewModel()
    }
    
    public func moveToViewController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    public func setDisplayItems(_ items: [PlaceDisplayItem]) {
        self.placesDisplayItems = items
    }
}

extension PlacesViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            viewModel?.createPlaceRequested()
        } else {
            viewModel?.showPlaceRequested(placesDisplayItems[indexPath.row].id)
        }
    }
}

extension PlacesViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesDisplayItems.count + 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        } else {
            return 160
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = makeAddPlaceCell() {
                return cell
            }
            return UITableViewCell()
        } else {
            if let cell = makePlaceCell(indexPath.row - 1) {
                return cell
            }
            return UITableViewCell()
        }
    }

    private func makeAddPlaceCell() -> AddCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell") as? AddCell else {
            return nil
        }

        cell.addLabel.text = "Add new Place"
        return cell
    }

    private func makePlaceCell(_ index: Int) -> PlaceCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as? PlaceCell else {
            return nil
        }

        cell.titleLabel.text = placesDisplayItems[index].name
        cell.descriptionLabel.text = placesDisplayItems[index].note
        cell.placePreview.image = placesDisplayItems[index].photo
        return cell
    }


}
