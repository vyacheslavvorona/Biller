//
//  BillModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/26/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import RealmSwift

public enum BillType: Int {
    case BASIC = 1
}

public class Bill: BaseModel, BaseModelProtocol {
    
    @objc public dynamic var type: Int = 0
    @objc public dynamic var totalSum: Float = 0
    
    
}
