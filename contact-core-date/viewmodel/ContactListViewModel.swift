//
//  ContactListViewModel.swift
//  contact-core-date
//
//  Created by Thet Htun on 11/24/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation
import RxSwift

class ContactListViewModel: BaseViewModel {
    
    var contactList : PublishSubject<[ContactVO]> = PublishSubject()
    
    func addContact(data : ContactVO) {
        Repository.contactList.append(data)
        self.contactList.onNext(Repository.contactList)
    }
    
    func updateContact(data : ContactVO) {
        Repository.contactList = Repository.contactList.map { contact in
            if contact.username == data.username {
                return data
            }
            return contact
        }
        self.contactList.onNext(Repository.contactList)
    }
    
    func deleteContact(data : ContactVO) {
        Repository.contactList = Repository.contactList.filter { contact in
            contact.username != data.username
        }
        self.contactList.onNext(Repository.contactList)
    }
    
    func getContact(index: Int) -> ContactVO {
        return Repository.contactList[index]
    }
    
}
