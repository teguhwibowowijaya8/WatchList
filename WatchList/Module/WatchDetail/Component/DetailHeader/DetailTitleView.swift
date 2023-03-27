//
//  NamePriceTableViewCell.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class DetailTitleView: UIStackView {
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return nameLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        priceLabel.textAlignment = .right
        priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return priceLabel
    }()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupSelfAttributes()
        addSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelfAttributes()
        addSubviews()
    }
    
    func setupDetailTitle(productName: String, productPrice: String) {
        nameLabel.text = productName
        priceLabel.text = productPrice
    }
    
    private func setupSelfAttributes() {
        self.distribution = .fill
        self.alignment = .top
        self.spacing = 10
    }
    
    private func addSubviews() {
        self.addArrangedSubview(nameLabel)
        self.addArrangedSubview(priceLabel)
    }
}
