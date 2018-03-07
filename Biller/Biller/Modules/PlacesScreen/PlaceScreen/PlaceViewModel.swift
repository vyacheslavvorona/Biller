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
    var placeModel: PlaceModel? { get set }
}

public class PlaceViewModel: PlaceViewModelProtocol, PlaceViewModelInputProtocol {
    
    public weak var viewController: PlaceViewControllerProtocol?
    public var placeModel: PlaceModel?
}
