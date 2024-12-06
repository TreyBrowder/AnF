//
//  ANFExploreCardCellVMTests.swift
//  ANF Code TestTests
//
//  Created by Trey Browder on 12/6/24.
//

import XCTest
@testable import ANF_Code_Test

final class ANFExploreCardCellVMTests: XCTestCase {
    var mockService: MockCardDataService! // Instance property
    var testExploreCard: ExploreCard!
    var cellViewModel: CellViewModel!
    
    override func setUp() {
        super.setUp()
        
        // Initialize mock service with test card data
        mockService = MockCardDataService(mockData: testCard)
        
        // Decode the test card data
        guard let decodedCard = try? JSONDecoder().decode(ExploreCard.self, from: testCard) else {
            XCTFail("Failed to decode test card data")
            return
        }
        testExploreCard = decodedCard
        
        // Initialize the CellViewModel with the decoded card and mock service
        cellViewModel = CellViewModel(card: testExploreCard, imageService: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        testExploreCard = nil
        cellViewModel = nil
        super.tearDown()
    }
    
    func test_init_ShouldInitializeCorrectly() {
        XCTAssertEqual(cellViewModel.title, "TOPS STARTING AT $12")
        XCTAssertEqual(cellViewModel.topDescription, "A&F ESSENTIALS")
        XCTAssertEqual(cellViewModel.promoMessage, "USE CODE: 12345")
        XCTAssertEqual(cellViewModel.backgroundImageURL, "anf-20160527-app-m-shirts.jpg")
    }
    
    func test_buttonURLs_ShouldBeCorrect() {
        XCTAssertEqual(cellViewModel.shopMenURL, URL(string: "https://www.abercrombie.com/shop/us/mens-new-arrivals"))
        XCTAssertEqual(cellViewModel.shopWomenURL, URL(string: "https://www.abercrombie.com/shop/us/womens-new-arrivals"))
        XCTAssertNil(cellViewModel.shopNowURL) // "Shop Now" doesn't exist in this card
    }
    
    func test_fetchBackgroundImage_ShouldReturnImage() async {
        let sampleImage = UIImage(named: "anf-20160527-app-m-shirts")!
        mockService = MockCardDataService(mockData: testCard, mockImg: sampleImage)
        
        let image = await cellViewModel.fetchBackgroundImage()
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image, sampleImage)
    }
    
    func test_createAttributedBottomDescription_ShouldReturnAttributedString() {
        let attributedText = cellViewModel.createAttributedBottomDescription()
        XCTAssertNotNil(attributedText)
        XCTAssertTrue(attributedText?.string.contains("In stores & online. Exclusions apply.") ?? false)
        XCTAssertTrue(attributedText?.string.contains("See Details") ?? false)
    }
}
