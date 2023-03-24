//
//  NamePriceTableViewCell.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class NamePriceTableViewCell: UITableViewCell {
    
    var name: String?
    var price: Double?

    var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        return nameLabel
    }()
    
    var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        priceLabel.textAlignment = .right
        return priceLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell() {
        self.addSubview(stackView)
        setupStackView()
    }
    
    func setupStackView() {
        guard let name = self.name, let price = self.price else {return}
        nameLabel.text = name
        priceLabel.text = "Rp. \(price)"
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 28),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -28),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
        ])
    }
    

}
