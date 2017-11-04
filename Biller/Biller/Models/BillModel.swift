//
//  BillModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/26/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public enum BillType: Int {
    case BASIC = 0
}

public class BillModel: BaseModel, BaseModelProtocol {
    
    @objc private dynamic var type: Int = 0
    @objc public dynamic var name: String = ""
    @objc public dynamic var rating: Int = 0
    @objc public dynamic var photo: NSData?
    @objc public dynamic var tipsPercent: Float = 0
    
    public convenience init(type: BillType) {
        self.init()
        self.id = generateUuidString()
        self.type = type.rawValue
    }
}
