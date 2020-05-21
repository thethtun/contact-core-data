//
//  ContactData.swift
//  ContactSwiftUI
//
//  Created by Thet Htun on 5/13/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import Foundation


struct ContactVO : Identifiable {
    internal let id : String = UUID().uuidString
    let name : String
    let phoneNumbers : [PhoneNumberVO]
}

class PhoneNumberVO : Identifiable, ObservableObject {
    let id : String = UUID().uuidString
    @Published var number : String
    
    init(number : String) {
        self.number = number
    }
}
