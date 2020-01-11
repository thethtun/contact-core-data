//
//  Repository.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation


var tempContactList : [ContactVO] = [
    ContactVO(username: "Josh Noah", phoneNumbers: [
        PhoneNumberVO(number: "9838888812")
    ], emails: [
        EmailVO(address: "josh.dev@gmail.com")
    ], addresses: [
        AddressVO(fullAddress: "No.31, Jasmine Street, Paraka Avenue, NY")
    ]),
    
    ContactVO(username: "Ramona Jones", phoneNumbers: [
        PhoneNumberVO(number: "(012)-301-9538")
    ], emails: [
        EmailVO(address: "ramona.jones@example.com"),
        EmailVO(address: "cuttiegirl@example.com")
    ], addresses: [
        AddressVO(fullAddress: "9609 Stevens Creek Blvd")
    ]),
    
    ContactVO(username: "Nina Morrison", phoneNumbers: [
        PhoneNumberVO(number: "(753)-876-7755")
    ], emails: [
        EmailVO(address: "nina.morrison@example.com")
    ], addresses: [
        AddressVO(fullAddress: "665 Fairview St")
    ])
]
