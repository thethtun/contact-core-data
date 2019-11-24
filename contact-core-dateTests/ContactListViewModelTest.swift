//
//  ContactListViewModelTest.swift
//  contact-core-dateTests
//
//  Created by Thet Htun on 11/24/19.
//  Copyright © 2019 padc. All rights reserved.
//

import XCTest
@testable import RxSwift
@testable import contact_core_date

class ContactListViewModelTest: XCTestCase {
    
    let viewModel = ContactListViewModel()
    let bag = DisposeBag();
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_addContact() {
          
        viewModel.contactList.subscribe(onNext: { (contacts) in
            XCTAssert(contacts.count == 1, "Contact Inserted")
            
            ///Also test name, phone, address
        }, onError: { (error) in
            XCTFail(error.localizedDescription)
        }, onCompleted: {
            
        }) {
            print("disposed")
        }.disposed(by: bag)
        
        viewModel.addContact(data: ContactVO())
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
