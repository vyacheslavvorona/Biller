//
//  ConfigModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public class ConfigModel: BaseModel, BaseModelProtocol {
    
    @objc public dynamic var defaultCurrencyCode: String = ""
    @objc public dynamic var defaultTipsPercent: Float = 0
    @objc public dynamic var colorSchemeId: Int = 0
    @objc public dynamic var currentUser: PersonModel?
    
    public convenience required init() {
        self.init()
        
    }
}
