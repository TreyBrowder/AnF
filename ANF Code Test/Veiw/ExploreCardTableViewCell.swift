//
//  ExploreCardTableViewCell.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import UIKit

class ExploreCardTableViewCell: UITableViewCell {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let topDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let promoMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .red
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let bottomDescriptionLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textColor = .gray
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        textView.textAlignment = .center
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        return textView
    }()
    
    private let shopMenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Shop Men", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let shopWomenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Shop Women", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(topDescriptionLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(promoMessageLabel)
        contentView.addSubview(bottomDescriptionLabel)
        contentView.addSubview(shopMenButton)
        contentView.addSubview(shopWomenButton)
    }
    
    private func setupConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        topDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        promoMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        shopMenButton.translatesAutoresizingMaskIntoConstraints = false
        shopWomenButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Background Image
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Top Description
            topDescriptionLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 8),
            topDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: topDescriptionLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Promo Message
            promoMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            promoMessageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            promoMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Bottom Description
            bottomDescriptionLabel.topAnchor.constraint(equalTo: promoMessageLabel.bottomAnchor, constant: 4),
            bottomDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Shop Men Button
            shopMenButton.topAnchor.constraint(equalTo: bottomDescriptionLabel.bottomAnchor, constant: 12),
            shopMenButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shopMenButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shopMenButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Shop Women Button
            shopWomenButton.topAnchor.constraint(equalTo: shopMenButton.bottomAnchor, constant: 12),
            shopWomenButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shopWomenButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shopWomenButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Bottom Padding
            shopWomenButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with viewModel: CellViewModel) {
        // Set default placeholder image
        backgroundImageView.image = UIImage(named: "placeholder")

        // Assign text properties
        titleLabel.text = viewModel.title
        topDescriptionLabel.text = viewModel.topDescription
        promoMessageLabel.text = viewModel.promoMessage
        bottomDescriptionLabel.attributedText = viewModel.createAttributedBottomDescription()

        // Fetch and set the background image asynchronously
        Task {
            if let image = await viewModel.fetchBackgroundImage() {
                DispatchQueue.main.async {
                    self.backgroundImageView.image = image
                }
            } else {
                print("DEBUG: Failed to load image for URL: \(viewModel.backgroundImageURL)")
            }
        }
    }
    
//    private func createAttributedBottomDescription(from description: String) -> NSAttributedString {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = .center
//        
//        // Base attributes for the text
//        let attributedString = NSMutableAttributedString(string: "In stores & online. Exclusions apply. ", attributes: [
//            .paragraphStyle: paragraphStyle,
//            .font: UIFont.systemFont(ofSize: 12),
//            .foregroundColor: UIColor.gray
//        ])
//        
//        // Extract the "See Details" hyperlink
//        if let _ = description.range(of: "See Details"),
//           let hrefStart = description.range(of: "href=\""),
//           let hrefEnd = description.range(of: "\">", range: hrefStart.upperBound..<description.endIndex) {
//            let url = String(description[hrefStart.upperBound..<hrefEnd.lowerBound])
//            let linkText = NSAttributedString(string: "See Details", attributes: [
//                .link: URL(string: url)!,
//                .foregroundColor: UIColor.blue,
//                .underlineStyle: NSUnderlineStyle.single.rawValue,
//                .paragraphStyle: paragraphStyle
//            ])
//            attributedString.append(linkText)
//        }
//        
//        return attributedString
//    }
}

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
