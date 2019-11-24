//
//  ContactVO.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation


struct ContactVO {
    var username : String = ""
    var phoneNumbers = [PhoneNumberVO]()
    var emails = [EmailVO]()
    var addresses = [AddressVO]()
    let createdAt : Date = Date()
    let updatedAt : Date = Date()
    
    init() {
        
    }
    
    init(username : String, phoneNumbers : [PhoneNumberVO], emails : [EmailVO], addresses : [AddressVO]) {
        self.username = username
        self.phoneNumbers = phoneNumbers
        self.emails = emails
        self.addresses = addresses
    }
    
}
