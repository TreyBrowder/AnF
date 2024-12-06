//
//  ExploreCardTableViewCell.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import UIKit

class ExploreCardTableViewCell: UITableViewCell {
    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.accessibilityIdentifier = "ExploreCardBackgroundImageView"
        imageView.image = UIImage(named: "placeholder")
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
        label.accessibilityIdentifier = "ExploreCardTitleLabel"
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
        button.isHidden = true
        return button
    }()
    
    private let shopWomenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Shop Women", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.isHidden = true
        return button
    }()
    
    private let shopNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Shop Now", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.isHidden = true
        return button
    }()
    
    // MARK: - URL Properties
    private var shopMenURL: URL?
    private var shopWomenURL: URL?
    private var shopNowURL: URL?
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(topDescriptionLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(promoMessageLabel)
        contentView.addSubview(bottomDescriptionLabel)
        contentView.addSubview(shopMenButton)
        contentView.addSubview(shopWomenButton)
        contentView.addSubview(shopNowButton)
    }
    
    private func setupConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        topDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        promoMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        shopMenButton.translatesAutoresizingMaskIntoConstraints = false
        shopWomenButton.translatesAutoresizingMaskIntoConstraints = false
        shopNowButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            // Shop Now Button
            shopNowButton.topAnchor.constraint(equalTo: shopWomenButton.bottomAnchor, constant: 12),
            shopNowButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shopNowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shopNowButton.heightAnchor.constraint(equalToConstant: 40),
            shopNowButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupActions() {
        shopMenButton.addTarget(self, action: #selector(didTapShopMen), for: .touchUpInside)
        shopWomenButton.addTarget(self, action: #selector(didTapShopWomen), for: .touchUpInside)
        shopNowButton.addTarget(self, action: #selector(didTapShopNow), for: .touchUpInside)
    }
    
    // MARK: - Button Actions
    @objc private func didTapShopMen() {
        if let url = shopMenURL {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func didTapShopWomen() {
        if let url = shopWomenURL {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func didTapShopNow() {
        if let url = shopNowURL {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Configuration
    func configure(with cellVM: CellViewModel) {
        // Assign text properties
        titleLabel.text = cellVM.title
        topDescriptionLabel.text = cellVM.topDescription
        promoMessageLabel.text = cellVM.promoMessage
        bottomDescriptionLabel.attributedText = cellVM.createAttributedBottomDescription()

        // Assign URLs for buttons
        shopMenURL = cellVM.shopMenURL
        shopWomenURL = cellVM.shopWomenURL
        shopNowURL = cellVM.shopNowURL

        // Toggle visibility of buttons
        shopMenButton.isHidden = shopMenURL == nil
        shopWomenButton.isHidden = shopWomenURL == nil
        shopNowButton.isHidden = shopNowURL == nil

        // Fetch and set the background image asynchronously
        Task {
            if let image = await cellVM.fetchBackgroundImage() {
                DispatchQueue.main.async {
                    self.backgroundImageView.image = image
                }
            } else {
                print("DEBUG: Failed to load image for URL: \(cellVM.backgroundImageURL)")
            }
        }
    }
    
    // MARK: - Preserve TextView Appearance
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        preserveTextViewAppearance()
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        preserveTextViewAppearance()
    }

    private func preserveTextViewAppearance() {
        bottomDescriptionLabel.textColor = .gray
        bottomDescriptionLabel.backgroundColor = .clear
    }
}
