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
    private(set) var loadedImage: UIImage?
    
    // MARK: - Initializer
    init(card: ExploreCard) {
        self.title = card.title
        self.topDescription = card.topDescription
        self.promoMessage = card.promoMessage
        self.rawBottomDescription = card.bottomDescription
        self.backgroundImageURL = card.backgroundImage
    }
    
    // MARK: - Business Logic
    func fetchBackgroundImage() async -> UIImage? {
        // Return cached image if already loaded
        if let loadedImage = loadedImage {
            return loadedImage
        }
        
        guard let url = URL(string: backgroundImageURL) else {
            print("DEBUG: Invalid URL: \(backgroundImageURL)")
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate HTTP response
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("DEBUG: Failed to load image. HTTP Status Code: \(httpResponse.statusCode)")
                return nil
            }
            
            // Validate image data
            guard let image = UIImage(data: data) else {
                print("DEBUG: Failed to create UIImage from data")
                return nil
            }
            
            // Cache the image
            self.loadedImage = image
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
