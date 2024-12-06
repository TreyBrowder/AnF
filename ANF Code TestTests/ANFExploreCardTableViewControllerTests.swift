//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//


import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {
    
    var mockService: MockCardDataService!
    var vc: ANFExploreCardTableViewController!
    
    override func setUp() {
        mockService = MockCardDataService(mockData: testCardData)
        vc = ANFExploreCardTableViewController(service: mockService)
        vc.loadViewIfNeeded()
    }
    
    override func tearDown() {
        mockService = nil
        vc = nil
    }
    
    func test_numberOfSections_ShouldBeOne() {
        mockService = MockCardDataService(mockData: testCardData, mockError: nil)
        vc = ANFExploreCardTableViewController(service: mockService)
        vc.loadViewIfNeeded()
        
        // Act
        Task { await vc.cardVM.getCardData() }

        // Assert
        XCTAssertEqual(vc.numberOfSections(in: vc.tableView), 1, "Table view should have 1 section")
    }
    
    
    func test_numberOfRows_ShouldBeThree() {
        let expectation = XCTestExpectation(description: "Table view should reload after data is fetched")
        vc.cardVM.delegate = vc
        
        // Act
        Task {
            await vc.cardVM.getCardData()
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
        
        // Assert
        let numberOfRows = vc.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 3, "Table view should have 3 rows")
    }
    
}
