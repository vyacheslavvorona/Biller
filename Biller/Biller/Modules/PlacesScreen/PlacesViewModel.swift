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

public protocol PlacesViewControllerProtocol {
    var placesDisplayItems: [PlaceDisplayItem] { get set }
    
    func moveToViewController(viewController: UIViewController)
}

public class PlacesViewModel: PlacesViewModelProtocol {
    
    public var viewController: PlacesViewControllerProtocol?
    
    public func createPlaceRequested() {
        do {
            let realm = try Realm()
            try realm.write {
                let newPlace = try PlaceModel.create(realm: Realm.getRealm(), value: PlaceModel(type: .BASIC), update: false)
                self.newPlaceCreated(place: newPlace)
            }
        } catch {
            print("Could not create a new place model due to Error: \(error)")
        }
    }
    
    private func newPlaceCreated(place: PlaceModel) {
        openPlaceScreen(place: place)
    }
    
    private func openPlaceScreen(place: PlaceModel) {
        let placeViewController = PlaceViewController()
        if var placeViewModel = placeViewController.viewModel as? PlaceViewModelInputProtocol {
           placeViewModel.placeModel = place
        }
        viewController?.moveToViewController(viewController: placeViewController)
    }
}
