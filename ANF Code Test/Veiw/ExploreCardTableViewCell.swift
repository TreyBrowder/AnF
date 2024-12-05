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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let promoMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let topDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let bottomDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(promoMessageLabel)
        contentView.addSubview(topDescriptionLabel)
        contentView.addSubview(bottomDescriptionLabel)
    }
    
    private func setupConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        promoMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        topDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            promoMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            promoMessageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            promoMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            topDescriptionLabel.topAnchor.constraint(equalTo: promoMessageLabel.bottomAnchor, constant: 8),
            topDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            bottomDescriptionLabel.topAnchor.constraint(equalTo: topDescriptionLabel.bottomAnchor, constant: 8),
            bottomDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bottomDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with card: ExploreCard) {
        titleLabel.text = card.title
        promoMessageLabel.text = card.promoMessage
        topDescriptionLabel.text = card.topDescription
        bottomDescriptionLabel.text = card.bottomDescription
        backgroundImageView.image = UIImage(named: card.backgroundImage)
    }
}
