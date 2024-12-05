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
    
    func configure(with card: ExploreCard) {
        backgroundImageView.image = UIImage(named: card.backgroundImage)
        topDescriptionLabel.text = card.topDescription
        titleLabel.text = card.title
        promoMessageLabel.text = card.promoMessage
        
        if let bottomDescription = card.bottomDescription {
            let attributedString = NSMutableAttributedString(string: "In stores & online. Exclusions apply. ")
            
            if let range = bottomDescription.range(of: "See Details"),
               let hrefStart = bottomDescription.range(of: "href=\""),
               let hrefEnd = bottomDescription.range(of: "\">", range: hrefStart.upperBound..<bottomDescription.endIndex) {
                let url = String(bottomDescription[hrefStart.upperBound..<hrefEnd.lowerBound])
                attributedString.append(NSAttributedString(string: "See Details", attributes: [.link: URL(string: url)!, .foregroundColor: UIColor.blue]))
            }
            bottomDescriptionLabel.attributedText = attributedString
        } else {
            bottomDescriptionLabel.text = nil
        }
    }
}
