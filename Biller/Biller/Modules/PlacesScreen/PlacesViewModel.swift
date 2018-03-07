//
//  PlacesViewModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 11/4/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import RealmSwift
import Result

public protocol PlacesViewControllerProtocol: class {    
    func moveToViewController(_ viewController: UIViewController)
    func setDisplayItems(_ items: [PlaceDisplayItem])
}

public class PlacesViewModel: PlacesViewModelProtocol {
    
    public weak var viewController: PlacesViewControllerProtocol?

    public func displayItemsRequested() {
        if let vc = viewController {
            vc.setDisplayItems(convertPlacesToDisplayItems(loadPlaces()))
        }
    }

    private func loadPlaces() -> [PlaceModel] {
        return Array(PlaceModel.objects())
    }

    private func convertPlacesToDisplayItems(_ places: [PlaceModel]) -> [PlaceDisplayItem] {
        return places.map { place in
            return PlaceDisplayItem.placeToDisplayItem(place)
        }
    }
    
    public func createPlaceRequested() {
        do {
            let realm = try Realm()
            try realm.write {
                let newPlace = try PlaceModel.create(realm, value: PlaceModel(type: .basic), update: false)
                self.newPlaceCreated(place: newPlace)
            }
        } catch {
            print("Could not create a new place model due to Error: \(error)")
        }
    }

    public func showPlaceRequested(_ placeId: String) {
        if let place = PlaceModel.object(pk: placeId) {
            openPlaceScreen(place: place)
        } else {
            print("Place with id \(placeId) was not found in Realm")
        }
    }
    
    private func newPlaceCreated(place: PlaceModel) {
        openPlaceScreen(place: place)
    }
    
    private func openPlaceScreen(place: PlaceModel) {
        let placeStoryBoard = UIStoryboard(name: "Place", bundle: nil)
        if let placeViewController = placeStoryBoard.instantiateViewController(withIdentifier: "Place") as? PlaceViewController,
            var placeViewModel = placeViewController.viewModel as? PlaceViewModelInputProtocol {

                placeViewModel.placeModel = place
            viewController?.moveToViewController(placeViewController)
        }
    }
}
