//
//  addContact.swift
//  contact-core-dateUITests
//
//  Created by Thet Htun on 11/24/19.
//  Copyright © 2019 padc. All rights reserved.
//

import XCTest

class addContact: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //        tempContactList.removeAll()
    }
    
    
    func test_AddContact() {
        
        let app = XCUIApplication()
        
        app.navigationBars["Contacts"].buttons["Add"].tap()
        
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["User Name"].tap()
        elementsQuery.textFields["User Name"].typeText("Thet")
        
        elementsQuery.buttons["icons8 add"].tap()
        //        let enterCcNumberTextField = elementsQuery.textFields["Enter cc-number"]
        elementsQuery.textFields["Enter cc-number"].firstMatch.tap()
        elementsQuery.textFields["Enter cc-number"].firstMatch.typeText("883881283123")
        
        app.navigationBars["New Contact"].buttons["Done"].tap()
        
        app.tables.staticTexts["Thet"].tap()
        
        app.navigationBars.firstMatch.buttons["Contacts"].tap()
        
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
        
    }
    
    func test_EditContact() {
        
        let app = XCUIApplication()
        app.navigationBars["Contacts"].buttons["Add"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["User Name"].tap()
        elementsQuery.textFields["User Name"].typeText("Thet")
        
        elementsQuery.buttons["icons8 add"].tap()
        //        let enterCcNumberTextField = elementsQuery.textFields["Enter cc-number"]
        elementsQuery.textFields["Enter cc-number"].firstMatch.tap()
        elementsQuery.textFields["Enter cc-number"].firstMatch.typeText("883881283123")
        
        app.navigationBars["New Contact"].buttons["Done"].tap()
        
        app.navigationBars["Contacts"].buttons["Edit"].tap()
        
        app.tables.buttons["Delete Thet"].tap()
        
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
    }
    
    
}
