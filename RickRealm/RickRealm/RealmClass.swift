//
//  RealmClass.swift
//  RickRealm
//
//  Created by Рахим Габибли on 04.07.2024.
//

import Foundation

import RealmSwift

class RMRealmClass: Object {
    @objc dynamic var personIDRealm = String()
    @objc dynamic var nameRealm = String()
    @objc dynamic var imageURLRealm = String()
    @objc dynamic var statusRealm = String()
    @objc dynamic var genderRealm = String()
    @objc dynamic var speciesRealm = String()
    @objc dynamic var locationRealm = String()

    override static func primaryKey() -> String? {
        return "personIDRealm"
    }
}
