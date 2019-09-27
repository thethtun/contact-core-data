//
//  ContactVO.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation
import RealmSwift

class ContactVO : Object {
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var username : String = ""
    let phoneNumbers = List<PhoneNumberVO>()
    let emails = List<EmailVO>()
    let addresses = List<AddressVO>()
    @objc dynamic var createdAt : Date = Date()
    @objc dynamic var updatedAt : Date = Date()
    

    override static func primaryKey() -> String? {
        return "id"
    }
    
}
