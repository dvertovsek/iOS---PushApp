//
//  PushAppTests.swift
//  PushAppTests
//
//  Created by MTLab on 22/01/16.
//  Copyright © 2016 dare. All rights reserved.
//

import XCTest
//import Starscream
class PushAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSockets() {
        
//        let url = "10.24.11.69:8900"
        let urlString = "ws://10.24.11.69:8907"
        let url = NSURL(string: urlString)!
        let socket = WebSocket(url: url)
        
        let expectation = expectationWithDescription("nije spojio se na socket")
        
        socket.onConnect = {

            expectation.fulfill()
        }
        
        socket.connect()
 
        waitForExpectationsWithTimeout(4, handler: nil)
    }
    
    func testSocketIO()
    {
        let urlString = "10.24.11.69:8907"
//        let urlString = "127.0.0.1:8907"
        
        let expectation = expectationWithDescription("nije spojio se na socket")
        let con = ConnectionSocketIO(urlString: urlString)
        
        con.connect(){
            expectation.fulfill()
        }
        
        
        waitForExpectationsWithTimeout(4, handler: nil)

    }
    
        
    
}
