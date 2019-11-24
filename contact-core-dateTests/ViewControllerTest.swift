//
//  ViewControllerTest.swift
//  contact-core-dateTests
//
//  Created by Thet Htun on 11/24/19.
//  Copyright © 2019 padc. All rights reserved.
//

import XCTest
@testable import contact_core_date

class ViewControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ContactListVC() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        XCTAssertNotNil(storyboard, "Storyboard not nil")
        let viewcontroller = storyboard.instantiateViewController(identifier: "ContactListViewController") as? ContactListViewController
        XCTAssertNotNil(viewcontroller, "ViewController not nil")
        _ = viewcontroller?.view
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
