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
    case basic = 0
    case bill = 1
    case billPosition = 2
    case place = 3
    case person = 4
}

public class CommentModel: BaseModel, BaseModelProtocol {
    
    @objc private dynamic var type: Int = 0
    public var commentType: CommentType {
        get {
            return CommentType.init(rawValue: self.type) ?? .basic
        }
        set {
            self.type = newValue.rawValue
        }
    }
    @objc public dynamic var text: String = ""
    @objc public dynamic var owner: BaseModel?
    
    public convenience init(type: CommentType, text: String?) {
        self.init()
        self.id = generateUuidString()
        self.type = type.rawValue

        if let t = text {
            self.text = t
        }
    }
}
