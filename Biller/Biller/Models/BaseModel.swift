//
//  BaseModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/26/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import RealmSwift

public class BaseModel: Object {
    
    @objc public dynamic var id: Int = 0
    @objc public dynamic var created: Date?
    @objc public dynamic var lastUpdated: Date?
    
    // Int value of primary key for Realm Object
    var primaryKeyIntValue: Int? {
        if let keyName = type(of: self).primaryKey() {
            if let v = self[keyName] {
                return (v as! Int)
            }
        }
        return nil
    }
    
    // String value of primary key for Realm Object
    var primaryKeyStringValue: String? {
        if let keyName = type(of: self).primaryKey() {
            if let v = self[keyName] {
                return "\(v)"
            }
        }
        return nil
    }
    
    // Any value of primary key for Realm Object
    var primaryKeyAnyValue: Any? {
        if let keyName = type(of: self).primaryKey() {
            if let v = self[keyName] {
                return v
            }
        }
        return nil
    }
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public protocol BaseModelProtocol {
    
    static func relations() -> [RelationshipData]
    static func includeRelations() -> [String : BaseModelProtocol.Type]
    static func excludeSubRelationships() -> [String]
}

public extension BaseModelProtocol where Self: BaseModel {
    
    static func relations() -> [RelationshipData] {
        return self.includeRelations().map { (name, type) in
            return RelationshipData(name: name, type: type, include: true)
        }
    }
    
    static func includeRelations() -> [String : BaseModelProtocol.Type] { return [:] }
    static func excludeSubRelationships() -> [String] { return [] }
    
    // Get an Object by its primary key value
    static func object(realm: Realm = Realm.getRealm(), pk pkValue: Any) -> Self? {
        return realm.object(ofType: self, forPrimaryKey: pkValue)
    }
    
    // Create a Realm Object with given values
    static func create(realm: Realm = Realm.getRealm(), value: Any = [:], update: Bool = false) throws -> Self {
        return realm.create(Self.self, value: value, update: update)
    }
}

public struct RelationshipData {
    
    let name: String
    let type: BaseModelProtocol.Type
    let excludeSubs: [String]?      //  don't include this sub-relationship
    
    var object: Object.Type {
        return type as! Object.Type // swiftlint:disable:this force_cast
    }
    
    init(name: String, type: BaseModelProtocol.Type, include: Bool, storeAsJson: Bool = false, excludeSubs: [String]? = nil) {
        self.name = name
        self.type = type
        self.excludeSubs = excludeSubs
        assert(type is Object.Type, "we can only support Objects.Type that also have BaseModelProtocol.Type ")
    }
}

