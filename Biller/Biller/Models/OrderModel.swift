//
//  BillPositionModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public class OrderModel: BaseModel, BaseModelProtocol {
    
    @objc public dynamic var amount: Int = 0
    @objc public dynamic var bill: BillModel?
    @objc public dynamic var menuPosition: MenuPositionModel?
    @objc public dynamic var owner: PersonModel?
    
    public convenience init(position: MenuPositionModel?) {
        self.init()
        self.id = generateUuidString()
        self.menuPosition = position
    }
}
