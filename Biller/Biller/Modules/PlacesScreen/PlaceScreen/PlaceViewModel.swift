//
//  PlaceViewModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 11/4/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import RealmSwift

public protocol PlaceViewControllerProtocol: class {
    
}

public protocol PlaceViewModelInputProtocol {
    func setPlaceModel(_ place: PlaceModel)
}

public class PlaceViewModel: PlaceViewModelProtocol, PlaceViewModelInputProtocol {
    
    private weak var viewController: PlaceViewControllerProtocol?

    public func setViewController(_ viewController: PlaceViewControllerProtocol) {
        self.viewController = viewController
    }

    private var placeModel: PlaceModel?
    public func setPlaceModel(_ place: PlaceModel) {
        placeModel = place
    }
}
