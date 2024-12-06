//
//  TestData.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import Foundation

//3 card Data Objects
let testCardData = """
[
  {
    "title": "TOPS STARTING AT $12",
    "backgroundImage": "anf-20160527-app-m-shirts.jpg",
    "content": [
      {
        "target": "https://www.abercrombie.com/shop/us/mens-new-arrivals",
        "title": "Shop Men"
      },
      {
        "target": "https://www.abercrombie.com/shop/us/womens-new-arrivals",
        "title": "Shop Women"
      }
    ],
    "promoMessage": "USE CODE: 12345",
    "topDescription": "A&F ESSENTIALS",
    "bottomDescription": "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>"
  },
  {
    "title": "T-SHIRT DRESSES",
    "backgroundImage": "anf-US-20160601-app-women-dresses.jpg",
    "topDescription": "THROW ON & GO",
    "content": [
      {
        "elementType": "hyperlink",
        "target": "https://www.abercrombie.com/shop/us/womens-dresses-and-rompers",
        "title": "SHOP NOW"
      }
    ]
  },
  {
    "title": "Spotlight On New",
    "backgroundImage": "anf-US-20160601-app-men-spotlight.jpg",
    "content": [
      {
        "elementType": "hyperlink",
        "target": "https://www.abercrombie.com/shop/us/mens-new-arrivals",
        "title": "SHOP NOW"
      }
    ]
  }
]
""".data(using: .utf8)!

//Misspelled title key on all 3 card data objects
let testInvalidCardData = """
[
  {
    "tile": "TOPS STARTING AT $12",
    "backgroundImage": "anf-20160527-app-m-shirts.jpg",
    "content": [
      {
        "target": "https://www.abercrombie.com/shop/us/mens-new-arrivals",
        "title": "Shop Men"
      },
      {
        "target": "https://www.abercrombie.com/shop/us/womens-new-arrivals",
        "title": "Shop Women"
      }
    ],
    "promoMessage": "USE CODE: 12345",
    "topDescription": "A&F ESSENTIALS",
    "bottomDescription": "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>"
  },
  {
    "title": "T-SHIRT DRESSES",
    "backgroundImage": "anf-US-20160601-app-women-dresses.jpg",
    "topDescription": "THROW ON & GO",
    "content": [
      {
        "elementType": "hyperlink",
        "target": "https://www.abercrombie.com/shop/us/womens-dresses-and-rompers",
        "title": "SHOP NOW"
      }
    ]
  },
  {
    "title": "Spotlight On New",
    "backgroundImage": "anf-US-20160601-app-men-spotlight.jpg",
    "content": [
      {
        "elementType": "hyperlink",
        "target": "https://www.abercrombie.com/shop/us/mens-new-arrivals",
        "title": "SHOP NOW"
      }
    ]
  }
]
""".data(using: .utf8)!
