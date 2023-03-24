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
        watchImageView.image = UIImage(named: "Watch")
        watchImageView.translatesAutoresizingMaskIntoConstraints = false
        return watchImageView
    }()
    
    let watchNameLabel: UILabel = {
        let watchNameLabel = UILabel()
        watchNameLabel.translatesAutoresizingMaskIntoConstraints = false
        watchNameLabel.font = UIFont.systemFont(ofSize: 10)
        return watchNameLabel
    }()
    
    let watchPriceLabel: UILabel = {
        let watchPriceLabel = UILabel()
        watchPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        watchPriceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return watchPriceLabel
    }()
    
    let watchDate: UILabel = {
        let watchDateLabel = UILabel()
        watchDateLabel.translatesAutoresizingMaskIntoConstraints = false
        watchDateLabel.textAlignment = .right
        watchDateLabel.font = UIFont.systemFont(ofSize: 8)
        watchDateLabel.textColor = .gray
        return watchDateLabel
    }()
    
    let namePriceDateStackView: UIStackView = {
        let namePriceDateStackView = UIStackView()
        namePriceDateStackView.translatesAutoresizingMaskIntoConstraints = false
        namePriceDateStackView.axis = .vertical
        namePriceDateStackView.spacing = 8
        namePriceDateStackView.distribution = .fillProportionally
        namePriceDateStackView.alignment = .top
        return namePriceDateStackView
    }()
    
    let watchLikedImageView: UIImageView = {
        let watchImageView = UIImageView()
        watchImageView.image = UIImage(systemName: "heart")
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
        cardView.addSubview(namePriceDateStackView)
        cardView.addSubview(watchLikedImageView)
        
        setupShadowView()
        setupCardView()
        setupWatchImageView()
        setupNamePriceDateStack()
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
        NSLayoutConstraint.activate([
            watchImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            watchImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            watchImageView.leftAnchor.constraint(equalTo: cardView.leftAnchor),
            watchImageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 1),
            watchImageView.widthAnchor.constraint(equalTo: watchImageView.heightAnchor, multiplier: 1)
        ])
    }
    
    func setupNamePriceDateStack() {
        guard let watch = self.watch else {return}
        watchDate.text = watch.category
        watchNameLabel.text = watch.name
        watchPriceLabel.text = watch.priceString
        print(watch.price)
        print(watch.priceString)
        
        namePriceDateStackView.addArrangedSubview(watchDate)
        namePriceDateStackView.addArrangedSubview(watchNameLabel)
        namePriceDateStackView.addArrangedSubview(watchPriceLabel)
        
        NSLayoutConstraint.activate([
            namePriceDateStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            namePriceDateStackView.leftAnchor.constraint(equalTo: watchImageView.rightAnchor, constant: 10),
            namePriceDateStackView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -10)
        ])
    }
    
    func setupLikedImageView() {
        NSLayoutConstraint.activate([
            watchLikedImageView.topAnchor.constraint(lessThanOrEqualTo: namePriceDateStackView.bottomAnchor, constant: 20),
            watchLikedImageView.leftAnchor.constraint(greaterThanOrEqualTo: watchImageView.rightAnchor, constant: 10),
            watchLikedImageView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -10),
            watchLikedImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            watchLikedImageView.heightAnchor.constraint(equalToConstant: 20),
            watchLikedImageView.widthAnchor.constraint(equalToConstant: 20),
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
