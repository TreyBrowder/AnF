//
//  ANF_Code_TestUITests.swift
//  ANF Code TestUITests
//
//  Created by Trey Browder on 12/6/24.
//

import XCTest
@testable import ANF_Code_Test

final class ANF_Code_TestUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func test_cellForRowAtIndexPath_titleText_shouldNotBeBlank() {
        // Arrange: Find the first cell in the collection view
        let firstCellTitle = app.staticTexts["TOPS STARTING AT $12"]
        
        // Assert: Check that the first cell's title is correct
        XCTAssertTrue(firstCellTitle.exists, "The title text 'TOPS STARTING AT $12' does not exist in the first cell.")
    }
    
    func test_cellForRowAtIndexPath_ImageViewImage_shouldNotBeNil() {
        let firstCell = app.tables.cells.element(boundBy: 0)
        
        // Act: Locate the image view in the first cell
        let firstCellImageView = firstCell.images["ExploreCardBackgroundImageView"]
        
        // Assert: Ensure the image view exists
        XCTAssertTrue(firstCellImageView.exists, "The image view in the first cell should exist.")
    }
}
