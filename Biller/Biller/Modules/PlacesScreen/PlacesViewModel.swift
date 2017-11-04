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
}

public class PlacesViewModel: PlacesViewModelProtocol {
    
    public var viewController: PlacesViewControllerProtocol?
    
    public convenience init(name: String?) {
        self.init()
        
    }
    
}
