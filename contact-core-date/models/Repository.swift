//
//  Repository.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation


var tempContactList : [ContactVO] = []


func preloadData() {
    tempContactList.append(ContactVO(username: "Zaw Zin", phoneNumbers: [PhoneNumberVO](), emails: [EmailVO](), addresses: [AddressVO]()))
}
