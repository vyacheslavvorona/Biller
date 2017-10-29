//
//  CommentModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public enum CommentType: Int {
    case BASIC = 0
    case BILL = 1
    case BILL_POSITION = 2
    case PLACE = 3
    case PERSON = 4
}

public class CommentModel: BaseModel, BaseModelProtocol {
    
    @objc public dynamic var type: Int = 0
    @objc public dynamic var text: String = ""
    @objc public dynamic var owner: BaseModel?
    
    public convenience init(text: String?) {
        self.init()
        self.id = self.generateUuidString()
        
        if let t = text {
            self.text = t
        }
    }
}
