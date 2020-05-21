//
//  DatabaseManager.swift
//  ContactSwiftUI
//
//  Created by Thet Htun on 5/22/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import Foundation

class DatabaseManager {
    
    func saveUserContact(data : ContactVO) {
        let context = CoreDataStack.shared.viewContext
        let userContact = UserContact(context: context)
        userContact.name = data.name
        userContact.id = data.id
        
        data.phoneNumbers.forEach { (item) in
            let phoneNumber = UserPhoneNumber(context: context)
            phoneNumber.id = item.id
            phoneNumber.number = item.number
            userContact.addToPhone_numbers(phoneNumber)
        }
        
        do {
            try context.save()
        } catch {
            print("failed to save contact")
        }
    }
    
    func updateUserContact(oldData : UserContact, newData: ContactVO) {
        let context = CoreDataStack.shared.viewContext
        oldData.name = newData.name
        
        /**
         Current Logic
         Delete all old phone
         Add new phones
         
         Problems: Not really optimal!
         Should only update the altered attributes
         */
        
        //Delete old phone numbers
        oldData.phone_numbers?.allObjects.forEach({ (item) in
            let obj = item as! UserPhoneNumber
            context.delete(obj)
        })
        
        //Update new phone numbers
        newData.phoneNumbers.forEach { (item) in
            let phoneNumber = UserPhoneNumber(context: context)
            phoneNumber.id = item.id
            phoneNumber.number = item.number
            oldData.addToPhone_numbers(phoneNumber)
        }
        
        do {
            try context.save()
        } catch {
            print("failed to update contact")
        }
    }
    
    func deleteUserContact(data : UserContact) {
        let context = CoreDataStack.shared.viewContext
        do {
            context.delete(data)
            try context.save()
        } catch {
            print("Failed to delete contact : \(error.localizedDescription)")
        }
    }
    
}
