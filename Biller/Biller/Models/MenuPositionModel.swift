//
//  MenuPositionModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public enum MenuPositionType: Int {
    case BASIC = 0
    case DRINK = 1
    case FOOD = 2
}

public class MenuPositionModel: BaseModel, BaseModelProtocol, CurrencyProtocol {
    
    @objc private dynamic var type: Int = 0
    public var positionType: MenuPositionType {
        get {
            return MenuPositionType.init(rawValue: self.type) ?? .BASIC
        }
        set {
            self.type = newValue.rawValue
        }
    }
    @objc public dynamic var name: String = ""
    @objc public dynamic var cost: Float = 0
    @objc public dynamic var positionDescription: String = ""
    @objc public dynamic var rating: Int = 0
    @objc public dynamic var currencyCode: String = ""
    @objc public dynamic var photo: NSData?
    @objc public dynamic var place: PlaceModel?
    
    public convenience init(type: MenuPositionType, name: String?) {
        self.init()
        self.id = generateUuidString()
        self.type = type.rawValue
        
        if let n = name {
            self.name = n
        }
    }
}
