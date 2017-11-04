//
//  PersonModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public enum PersonType: Int {
    case BASIC = 0
}

public class PersonModel: BaseModel, BaseModelProtocol {
    
    @objc private dynamic var type: Int = 0
    @objc public dynamic var name: String = ""
    @objc public dynamic var cardNumber: String = "" //needs encryption?
    @objc public dynamic var photo: NSData?
    @objc public dynamic var defaultPhotoId: Int = 0
    @objc public dynamic var isCurrentUser: Bool = false
    @objc public dynamic var comment: CommentModel?
    
    public convenience init(name: String?) {
        self.init()
        self.id = self.generateUuidString()
        
        if let n = name {
            self.name = n
        }
        self.defaultPhotoId = Int(arc4random_uniform(21))
    }
}
