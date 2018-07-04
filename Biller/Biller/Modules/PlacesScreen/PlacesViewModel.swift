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

    public var notificationToken: NotificationToken?

    private weak var viewController: PlacesViewControllerProtocol?

    public var placeViewController: PlaceViewController?

    public func setViewController(_ viewController: PlacesViewControllerProtocol) {
        self.viewController = viewController
    }

    public func displayItemsRequested() {
        observePlaces()

        let placeStoryBoard = UIStoryboard(name: "Place", bundle: nil)
        if let placeVC = placeStoryBoard.instantiateViewController(withIdentifier: "Place") as? PlaceViewController {
            placeViewController = placeVC
        } else {
            print("can not instantiate ViewController with identifier: Place")
        }
    }

//    private func loadPlaces() -> [PlaceModel] { //add a way to filter places later?
//        return Array(PlaceModel.objects())
//    }

    private func observePlaces() {
        notificationToken = PlaceModel.objects().observe { [weak self] placesChanges in
            guard let this = self else { return }

            switch placesChanges {
            case .initial(let places):
                if let vc = this.viewController {
                    vc.setDisplayItems(this.convertPlacesToDisplayItems(Array(places)))
                }
            case .update(let places, _, _, _):
                if let vc = this.viewController {
                    vc.setDisplayItems(this.convertPlacesToDisplayItems(Array(places)))
                }
            case .error(let error):
                print("Error during observing Places list changes: \(error)")
            default: break
            }
        }
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
                self.newPlaceCreated(newPlace)
            }
        } catch {
            print("Could not create a new place model due to Error: \(error)")
        }
    }

    public func showPlaceRequested(_ placeId: String) {
        if let place = PlaceModel.object(pk: placeId) {
            openPlaceScreen(place)
        } else {
            print("Place with id \(placeId) was not found in Realm")
        }
    }
    
    private func newPlaceCreated(_ place: PlaceModel) {
        openPlaceScreen(place, placeEditable: true)
    }
    
    private func openPlaceScreen(_ place: PlaceModel, placeEditable: Bool = false) {
        if let placeVC = self.placeViewController,
             let placeViewModel = placeVC.viewModel as? PlaceViewModelInputProtocol {

            placeViewModel.setPlaceModel(place)
            placeViewModel.setIsPlaceEditable(placeEditable)
            viewController?.moveToViewController(placeVC)
        }
    }
}
