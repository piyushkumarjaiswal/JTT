//
//  Jet2TravelTaskTests.swift
//  Jet2TravelTaskTests
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import XCTest
@testable import Jet2TravelTask

class Jet2TravelTaskTests: XCTestCase {
 
  var manager: NetworkManager!
  
  /*Initialization of instances*/
  override func setUp() {
    manager = NetworkManager()
  }
  /*Tear down methode invoked after the code executes*/
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    manager = nil
  }
  /*Verifying api call getting Valid data*/
  func testApiResponse() {
    let expectations = expectation(description: "Api Response")
    let param = ["page":"1","limit":"10"]
    manager.fetchPost(detail: param, completion: {(detail, _) in
      XCTAssert(detail != nil, "Data is not receiving from server")
      expectations.fulfill()
    })
    waitForExpectations(timeout: 30) { error in
      if let error = error {
        print("Error: \(error.localizedDescription)")
      }
    }
  }
  /*This test case fetches all person records*/
  func testFetchFeedsFromCoreData() {
    let results = CoreDataStack.sharedInstance.fetchCodeDataResult()
    //Assert return numbers of todo items
    //Asserts that two optional values are equal.
    XCTAssert(((results?.count ?? 0) > 0), "Unable to find records in Core Data")
  }
  /*Verifying a valid rootcontroller is initalized*/
  func testRootInitialization() {
    if #available(iOS 13, *) {
      let window =  UIApplication.shared.windows.first { $0.isKeyWindow }
      XCTAssert(window?.rootViewController != nil, "Window having the root controller")
    } else {
      let window =  UIApplication.shared.keyWindow
      XCTAssert(window?.rootViewController != nil, "Window having the root controller")
    }
  }
  /*Verifying that storage data of sample.json file is in correct formate*/
  func testLocalDataWithValidFormate() {
    if let url = Bundle.main.url(forResource: "sample", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let dataModel = try? JSONDecoder().decode([FeedResult].self, from: data)
        XCTAssert(dataModel != nil, "Data is incompatible with model object")
      } catch {
        print("error:\(error)")
      }
    }
  }
}
