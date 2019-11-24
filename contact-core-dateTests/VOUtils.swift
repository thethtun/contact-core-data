//
//  VOUtils.swift
//  contact-core-dateTests
//
//  Created by Thet Htun on 11/24/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation
@testable import contact_core_date

class VOUtils: NSObject {
    static let testUsername = "Zaw Zaw"
    static let testPhone = "959388188823"
    static let testAddress = "Yangon"
    static let testEmail = "abc@gmail.com"
    
    static func generateDummyContactVO() -> ContactVO {
        
        let testPhones = [PhoneNumberVO(number: testPhone)]
        let testEmails = [EmailVO(address: testEmail)]
        let testAddresses = [AddressVO(fullAddress: testAddress)]
        
        let vo = ContactVO(username: testUsername, phoneNumbers: testPhones, emails: testEmails, addresses: testAddresses)
        
        return vo
    }
}
