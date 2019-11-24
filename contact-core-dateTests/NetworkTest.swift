//
//  NetworkTest.swift
//  contact-core-dateTests
//
//  Created by Thet Htun on 11/24/19.
//  Copyright © 2019 padc. All rights reserved.
//

import XCTest

class NetworkTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let url = URL(string: "https://baconipsum.com/api/?type=all-meat&sentences=4&start-with-lorem=1")!
        
        let exp = expectation(description: "expecting to get success response")
        
        
        let dataTask = URLSession.shared.dataTask(with: url) {
                                (data, urlResponse, error) in
            
            XCTAssertNil(error)
            
            let TAG = "Nett"
            if error != nil {
                print("\(TAG): failed to fetch data : \(error!.localizedDescription)")
            }
            
            let response = urlResponse as! HTTPURLResponse
            
            if response.statusCode >= 200 && response.statusCode < 300 {
                guard let data = data else {
                    print("\(TAG): empty data")
                    return
                }
                
                if let result = try? JSONDecoder().decode([String].self, from: data) {
                    print("\(TAG) : \(result[0])")
                } else {
                    print("\(TAG): failed to parse data")
                }
            } else {
                print("\(TAG): Network Error - Code: \(response.statusCode)")
            }
            exp.fulfill()
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 6.0, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
