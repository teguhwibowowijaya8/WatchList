//
//  WatchListTableViewCell.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

protocol WatchListTableCellDelegate {
    func onWatchCellClicked(on watch: Watch)
}

class WatchListTableViewCell: UITableViewCell {
    
    var watch: Watch?
    var delegate: WatchListTableCellDelegate?
    private let defaultImage = UIImage(named: "Watch")
    
    let cardView: UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .white
        cardView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        cardView.layer.borderWidth = 1
        cardView.clipsToBounds = true
        cardView.tintColor = .black
        
        return cardView
    }()
    
    let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = false
        
        shadowView.layer.borderWidth = 3
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize(width: 1, height: 2)
        shadowView.layer.shadowRadius = 5
        
        return shadowView
    }()
    
    let watchImageView: UIImageView = {
        let watchImageView = UIImageView()
        watchImageView.translatesAutoresizingMaskIntoConstraints = false
        watchImageView.contentMode = .scaleAspectFit
        watchImageView.clipsToBounds = true
        return watchImageView
    }()
    
    let watchNameLabel: UILabel = {
        let watchNameLabel = UILabel()
        watchNameLabel.translatesAutoresizingMaskIntoConstraints = false
        watchNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        watchNameLabel.numberOfLines = 2
        return watchNameLabel
    }()
    
    let watchPriceLabel: UILabel = {
        let watchPriceLabel = UILabel()
        watchPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        watchPriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return watchPriceLabel
    }()
    
    let watchDate: UILabel = {
        let watchDateLabel = UILabel()
        watchDateLabel.translatesAutoresizingMaskIntoConstraints = false
        watchDateLabel.textAlignment = .right
        watchDateLabel.font = UIFont.systemFont(ofSize: 12)
        watchDateLabel.textColor = .gray
        return watchDateLabel
    }()
    
    let namePriceStackView: UIStackView = {
        let namePriceDateStackView = UIStackView()
        namePriceDateStackView.translatesAutoresizingMaskIntoConstraints = false
        namePriceDateStackView.axis = .vertical
        namePriceDateStackView.spacing = 5
        namePriceDateStackView.distribution = .fillProportionally
        namePriceDateStackView.alignment = .top
        return namePriceDateStackView
    }()
    
    let watchLikedImageView: UIImageView = {
        let watchImageView = UIImageView()
        watchImageView.translatesAutoresizingMaskIntoConstraints = false
        return watchImageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell() {
        self.contentView.addSubview(shadowView)
        self.contentView.addSubview(cardView)
        cardView.addSubview(watchImageView)
        cardView.addSubview(namePriceStackView)
        cardView.addSubview(watchLikedImageView)
        
        setupShadowView()
        setupCardView()
        setupWatchImageView()
        setupWatchCategoryLabel()
        setupNamePriceStack()
        setupLikedImageView()
        
    }
    
    func setupCardView() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            cardView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            cardView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
        ])
        
        let onTapGesture = UITapGestureRecognizer(target: self, action: #selector(onCellTaped))
        cardView.addGestureRecognizer(onTapGesture)
    }
    
    @objc func onCellTaped(_ sender: UITapGestureRecognizer) {
        guard let watch = watch else {return}
        delegate?.onWatchCellClicked(on: watch)
    }
    
    func setupWatchImageView() {
        watchImageView.loadImageFromUrl(watch?.imageUrlString, defaultImage: defaultImage)
        
        
        NSLayoutConstraint.activate([
            watchImageView.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor, constant: 10),
            watchImageView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -10),
            watchImageView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 10),
            watchImageView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.3),
            watchImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
            watchImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
    
    func setupWatchCategoryLabel() {
        guard let watchCategory = self.watch?.category else {return}
        watchDate.text = watchCategory.capitalized(with: .current)
        
        cardView.addSubview(watchDate)
        
        NSLayoutConstraint.activate([
            watchDate.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            watchDate.leftAnchor.constraint(equalTo: watchImageView.rightAnchor, constant: 10),
            watchDate.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -10),
        ])
    }
    
    func setupNamePriceStack() {
        guard let watch = self.watch else {return}
        watchNameLabel.text = watch.name
        watchPriceLabel.text = watch.priceString
        
        namePriceStackView.addArrangedSubview(watchNameLabel)
        namePriceStackView.addArrangedSubview(watchPriceLabel)
        
        NSLayoutConstraint.activate([
            namePriceStackView.topAnchor.constraint(equalTo: watchDate.bottomAnchor, constant: 10),
            namePriceStackView.leftAnchor.constraint(equalTo: watchImageView.rightAnchor, constant: 10),
            namePriceStackView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -10)
        ])
    }
    
    func setupLikedImageView() {
        guard let watchIsLiked = self.watch?.isLiked else {return}
        watchLikedImageView.image = UIImage(systemName: watchIsLiked ?
                                       "heart.fill" : "heart")
        
        NSLayoutConstraint.activate([
            watchLikedImageView.topAnchor.constraint(equalTo: namePriceStackView.bottomAnchor, constant: 20),
            watchLikedImageView.leftAnchor.constraint(greaterThanOrEqualTo: watchImageView.rightAnchor, constant: 10),
            watchLikedImageView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -10),
            watchLikedImageView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -10),
            watchLikedImageView.heightAnchor.constraint(equalToConstant: 20),
            watchLikedImageView.widthAnchor.constraint(equalTo: watchLikedImageView.heightAnchor),
        ])
    }
    
    func setupShadowView() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            shadowView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            shadowView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            shadowView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
        ])
    }
    
}
