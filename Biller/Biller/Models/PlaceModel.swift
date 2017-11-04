//
//  PlaceModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public enum PlaceType: Int {
    case BASIC = 0
}

public class PlaceModel: BaseModel, BaseModelProtocol {
    
    @objc private dynamic var type: Int = 0
    @objc public dynamic var name: String = ""
    @objc public dynamic var rating: Int = 0
    @objc public dynamic var photo: NSData?
    @objc public dynamic var comment: CommentModel?
    
    public convenience init(name: String?) {
        self.init()
        self.id = self.generateUuidString()
        
        if let n = name {
            self.name = n
        }
    }
}
