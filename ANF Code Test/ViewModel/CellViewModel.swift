//
//  CellViewModel.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import UIKit

class CellViewModel {
    // MARK: - Properties
    let title: String
    let topDescription: String?
    let promoMessage: String?
    let rawBottomDescription: String?
    let backgroundImageURL: String
    private let imageService: CardDataProtocol
    
    let shopMenURL: URL?
    let shopWomenURL: URL?
    let shopNowURL: URL?
    
    // MARK: - Initializer
    init(card: ExploreCard, imageService: CardDataProtocol) {
        self.title = card.title
        self.topDescription = card.topDescription
        self.promoMessage = card.promoMessage
        self.rawBottomDescription = card.bottomDescription
        self.backgroundImageURL = card.backgroundImage
        self.imageService = imageService
        
        let shopMenItem = card.content?.first { $0.title == "Shop Men" }
        let shopWomenItem = card.content?.first { $0.title == "Shop Women" }
        self.shopMenURL = shopMenItem.flatMap { URL(string: $0.target) }
        self.shopWomenURL = shopWomenItem.flatMap { URL(string: $0.target) }
        let shopNowItem = card.content?.first { $0.title == "SHOP NOW" }
        self.shopNowURL = shopNowItem.flatMap { URL(string: $0.target) }
    }
    
    // MARK: - Business Logic
    func fetchBackgroundImage() async -> UIImage? {
        if let cachedImage = await ImageCache.shared.get(key: backgroundImageURL) {
            return cachedImage
        }
        
        do {
            let image = try await imageService.fetchImage(for: backgroundImageURL)
            await ImageCache.shared.set(image: image, key: backgroundImageURL)
            return image
        } catch {
            print("DEBUG: Failed to fetch image: \(error.localizedDescription)")
            return nil
        }
    }
    
    func createAttributedBottomDescription() -> NSAttributedString? {
        guard let description = rawBottomDescription else { return nil }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // Base attributes for the text
        let attributedString = NSMutableAttributedString(
            string: "In stores & online. Exclusions apply. ",
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.gray
            ]
        )
        
        // Extract the "See Details" hyperlink
        if let _ = description.range(of: "See Details"),
           let hrefStart = description.range(of: "href=\""),
           let hrefEnd = description.range(of: "\">", range: hrefStart.upperBound..<description.endIndex) {
            let url = String(description[hrefStart.upperBound..<hrefEnd.lowerBound])
            if let validURL = URL(string: url) {
                let linkText = NSAttributedString(
                    string: "See Details",
                    attributes: [
                        .link: validURL,
                        .foregroundColor: UIColor.blue,
                        .underlineStyle: NSUnderlineStyle.single.rawValue,
                        .paragraphStyle: paragraphStyle
                    ]
                )
                attributedString.append(linkText)
            }
        }
        return attributedString
    }
}
