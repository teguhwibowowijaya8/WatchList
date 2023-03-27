//
//  DetailImageView.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 27/03/23.
//

import UIKit

class DetailImageView: UIView {
    private let defaultImage = UIImage(named: "Watch")
    
    private lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.layer.masksToBounds = true
        productImageView.contentMode = .scaleAspectFit
        return productImageView
    }()
    
    private lazy var bottomImageLabelContainerView: UIView = {
        let bottomImageLabelContainerView = UIView()
        bottomImageLabelContainerView.backgroundColor = .black.withAlphaComponent(0.5)
        bottomImageLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return bottomImageLabelContainerView
    }()
    
    private lazy var bottomImageLabel: UILabel = {
        let bottomImageLabel = UILabel()
        bottomImageLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomImageLabel.textColor = .white
        bottomImageLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return bottomImageLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelfAttributes()
        addSubviews()
        setupComponentsConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSelfAttributes()
        addSubviews()
        setupComponentsConstraints()
    }
    
    func setupDetailImage(with urlString: String, productCategory: String) {
        productImageView.loadImageFromUrl(urlString, defaultImage: defaultImage)
        bottomImageLabel.text = productCategory.capitalized(with: .current)
    }
    
    private func setupSelfAttributes() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    private func addSubviews() {
        self.addSubview(productImageView)
        self.addSubview(bottomImageLabelContainerView)
        bottomImageLabelContainerView.addSubview(bottomImageLabel)
    }
    
    private func setupComponentsConstraints() {
        NSLayoutConstraint.activate([
            
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            productImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            productImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            bottomImageLabelContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomImageLabelContainerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomImageLabelContainerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            
            bottomImageLabel.topAnchor.constraint(greaterThanOrEqualTo: bottomImageLabelContainerView.topAnchor, constant: 10),
            bottomImageLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomImageLabelContainerView.bottomAnchor, constant: -10),
            bottomImageLabel.leftAnchor.constraint(equalTo: bottomImageLabelContainerView.leftAnchor, constant: 10),
            bottomImageLabel.rightAnchor.constraint(equalTo: bottomImageLabelContainerView.rightAnchor, constant: -10),
            bottomImageLabel.centerYAnchor.constraint(equalTo: bottomImageLabelContainerView.centerYAnchor)
        ])
    }
}
