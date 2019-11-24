//
//  VOTest.swift
//  contact-core-dateTests
//
//  Created by Thet Htun on 11/24/19.
//  Copyright © 2019 padc. All rights reserved.
//

import XCTest
@testable import contact_core_date

class VOTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_EmailVO() {
        let testAddress = "Yangon"
        
        let vo = EmailVO(address: testAddress)
        XCTAssert(vo.address == testAddress , "Get Expected Address")
    }
    
    func test_PhoneNumberVO() {
        let testPhone = "959388188823"
        
        let vo = PhoneNumberVO(number: testPhone)
        XCTAssert(vo.number == testPhone, "Get Expected Phone")
    }
    
    func test_ContactVO() {
    
        let vo = VOUtils.generateDummyContactVO()
        
        XCTAssert(vo.username == VOUtils.testUsername, "Get Expected Username")
        XCTAssertGreaterThan(vo.phoneNumbers.count, 0)
        XCTAssertGreaterThan(vo.emails.count, 0)
        XCTAssertGreaterThan(vo.addresses.count, 0)
        
        let phone = vo.phoneNumbers[0]
        XCTAssert(phone.number == VOUtils.testPhone, "Check If Same Phone Number")
        let email = vo.emails[0]
        XCTAssert(email.address == VOUtils.testEmail, "Check If Same Email")
        let address = vo.addresses[0]
        XCTAssert(address.fullAddress == VOUtils.testAddress, "Check If Same Address")
        
        
    }
    
    
    func test_Empty_ContactVO() {
        let vo = ContactVO()
        XCTAssert(vo.username == "", "User Name Must Be Empty")
        XCTAssertEqual(vo.phoneNumbers.count, 0)
        XCTAssertEqual(vo.emails.count, 0)
        XCTAssertEqual(vo.addresses.count, 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            test_EmailVO()
        
        }
    }

}
