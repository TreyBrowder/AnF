//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//


import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {
    
    var mockService: MockCardDataService!
    var cardVM: CardDataViewModel!
    var vc: ANFExploreCardTableViewController!
    
    override func setUp() {
        mockService = MockCardDataService(mockData: testCardData)
        cardVM = CardDataViewModel(service: mockService)
        vc = ANFExploreCardTableViewController(service: mockService)
        vc.loadViewIfNeeded()
    }
    
    override func tearDown() {
        mockService = nil
        cardVM = nil
        vc = nil
    }
    
    func test_numberOfSections_ShouldBeOne() {
        mockService = MockCardDataService(mockData: testCardData, mockError: nil)
        vc = ANFExploreCardTableViewController(service: mockService)
        vc.loadViewIfNeeded()
        
        // Act
        Task { await vc.cardVM.getCardData() } 
        
        // Assert
        XCTAssertEqual(vc.numberOfSections(in: vc.tableView), 1, "Table view should have exactly 1 section")
    }
    
    
    func test_numberOfRows_ShouldBeTen() {
        //        let numberOfRows = testInstance.tableView(testInstance.tableView, numberOfRowsInSection: 0)
        //        XCTAssert(numberOfRows == 10, "table view should have 10 cells")
    }
    
    func test_cellForRowAtIndexPath_titleText_shouldNotBeBlank() {
        //        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        //        let title = firstCell.viewWithTag(1) as? UILabel
        //        XCTAssert(title?.text?.count ?? 0 > 0, "title should not be blank")
    }
    
    func test_cellForRowAtIndexPath_ImageViewImage_shouldNotBeNil() {
        //        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        //        let imageView = firstCell.viewWithTag(2) as? UIImageView
        //        XCTAssert(imageView?.image != nil, "image view image should not be nil")
    }
}
