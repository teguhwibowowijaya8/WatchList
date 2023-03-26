//
//  WatchImageTableViewCell.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class WatchImageTableViewCell: UITableViewCell {
    
    private let defaultImage = UIImage(named: "Watch")
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        return containerView
    }()
    
    private lazy var watchImageView: UIImageView = {
        let watchImageView = UIImageView()
        watchImageView.translatesAutoresizingMaskIntoConstraints = false
        watchImageView.layer.masksToBounds = true
        watchImageView.contentMode = .scaleAspectFit
        return watchImageView
    }()
    
    private lazy var bottomLabelContainerView: UIView = {
        let bottomLabelContainerView = UIView()
        bottomLabelContainerView.backgroundColor = .black.withAlphaComponent(0.5)
        bottomLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return bottomLabelContainerView
    }()
    
    private lazy var bottomImageLabel: UILabel = {
        let bottomImageLabel = UILabel()
        bottomImageLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomImageLabel.textColor = .white
        bottomImageLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return bottomImageLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(imageUrlString: String, watchType: String) {
        watchImageView.loadImageFromUrl(imageUrlString, defaultImage: defaultImage)
        bottomImageLabel.text = watchType.capitalized(with: .current)
        
        self.addSubview(containerView)
        containerView.addSubview(watchImageView)
        containerView.addSubview(bottomLabelContainerView)
        bottomLabelContainerView.addSubview(bottomImageLabel)
        
        
        setupComponentsConstraints()
    }
    
    private func setupComponentsConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -14),
            
            
            watchImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            watchImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            watchImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            watchImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10),
            watchImageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            bottomLabelContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomLabelContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            bottomLabelContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
//            bottomLabelContainerView.heightAnchor.constraint(equalToConstant: 40),
            
            
            bottomImageLabel.topAnchor.constraint(greaterThanOrEqualTo: bottomLabelContainerView.topAnchor, constant: 10),
            bottomImageLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomLabelContainerView.bottomAnchor, constant: -10),
            bottomImageLabel.leftAnchor.constraint(equalTo: bottomLabelContainerView.leftAnchor, constant: 10),
            bottomImageLabel.rightAnchor.constraint(equalTo: bottomLabelContainerView.rightAnchor, constant: -10),
            bottomImageLabel.centerYAnchor.constraint(equalTo: bottomLabelContainerView.centerYAnchor)
        ])
    }
    
}
