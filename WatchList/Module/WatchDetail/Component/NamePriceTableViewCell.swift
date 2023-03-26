//
//  NamePriceTableViewCell.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class NamePriceTableViewCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 10
        return stackView
    }()
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(watchName: String, watchPrice: String) {
        nameLabel.text = watchName
        priceLabel.text = watchPrice
        
        setupStackView()
    }
    
    private func setupStackView() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 28),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -28),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -6)
        ])
    }
    

}
