//
//  Storage.swift
//  CardsManagement
//
//  Created by Mac on 08/07/2023.
//

import Foundation
import RealmSwift

class Storage {
    
//    private init() {}
//    
//    class func sharedInstance() -> Storage {
//        struct Singleton{
//            static var shared = Storage()
//        }
//        return Singleton.shared
//    }
    
    func save(card:CardDTO) throws {
        let realm = try Realm()
        try realm.write(){
            realm.add(card)
        }
    }
    
    func getAllCards() throws -> [CardDTO] {
        let realm = try Realm()
        return Array(realm.objects(CardDTO.self))
    }
    
    func delete(id: String) throws {
        let realm = try Realm()
        let object = realm.objects(CardDTO.self).filter("id = %@", id).first
        try realm.write {
            if let obj = object {
                realm.delete(obj)
            }
        }
    }
    
    func deleteAllCards() throws {
        let realm = try Realm()
        let objects = realm.objects(CardDTO.self)
        try realm.write {
            realm.delete(objects)
        }
    }
    
    func updateCardAmount(id: String, newAmount: String) throws {
        let realm = try Realm()
        
        guard let card = realm.object(ofType: CardDTO.self, forPrimaryKey: id) else {
            return
        }
        
        try realm.write {
            var updatedAmount = (Double(card.amount) ?? 0) + (Double(newAmount) ?? 0)
            card.amount = String(updatedAmount)
            realm.add(card, update: .modified)
        }
    }
}

