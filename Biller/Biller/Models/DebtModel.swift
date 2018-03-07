//
//  DebtModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public enum DebtType: Int {
    case basic = 0
}

public class DebtModel: BaseModel, BaseModelProtocol, CurrencyProtocol {
    
    @objc private dynamic var type: Int = 0
    @objc public dynamic var sum: Float = 0
    @objc public dynamic var debter: PersonModel?
    @objc public dynamic var borrower: PersonModel?
    @objc public dynamic var currencyCode: String = ""
    
    public convenience init(type: DebtType, debterId: String, borrowerId: String, sum: Float) {
        self.init()
        self.id = generateUuidString()
        self.type = type.rawValue
    }
}

