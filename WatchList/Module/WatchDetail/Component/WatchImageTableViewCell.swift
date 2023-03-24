//
//  WatchImageTableViewCell.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class WatchImageTableViewCell: UITableViewCell {
    
    var watchImage = "Watch"
    
    let watchImageView: UIImageView = {
        let watchImageView = UIImageView()
        watchImageView.translatesAutoresizingMaskIntoConstraints = false
        watchImageView.layer.cornerRadius = 10
        watchImageView.layer.masksToBounds = true
        watchImageView.contentMode = .scaleAspectFill
        return watchImageView
    }()
    
    let bottomImageView: UIView = {
        let bottomImageView = UIView()
        bottomImageView.backgroundColor = .black.withAlphaComponent(0.3)
        bottomImageView.translatesAutoresizingMaskIntoConstraints = false
        return bottomImageView
    }()
    
    let bottomImageLabel: UILabel = {
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
    
    func setupCell() {
        self.addSubview(watchImageView)
        watchImageView.addSubview(bottomImageView)
        bottomImageView.addSubview(bottomImageLabel)
        
        setupWatchImage()
        setupBottomView()
        setupBottomLabel()
    }
    
    func setupWatchImage() {
        watchImageView.image = UIImage(named: watchImage)
        
        NSLayoutConstraint.activate([
            watchImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            watchImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            watchImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            watchImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            watchImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupBottomView() {
        NSLayoutConstraint.activate([
            bottomImageView.bottomAnchor.constraint(equalTo: watchImageView.bottomAnchor),
            bottomImageView.leftAnchor.constraint(equalTo: watchImageView.leftAnchor),
            bottomImageView.rightAnchor.constraint(equalTo: watchImageView.rightAnchor),
            bottomImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupBottomLabel() {
        bottomImageLabel.text = "Bagian Depan"
        
        NSLayoutConstraint.activate([
            bottomImageView.topAnchor.constraint(equalTo: bottomImageView.topAnchor, constant: 10),
            bottomImageLabel.bottomAnchor.constraint(equalTo: bottomImageView.bottomAnchor, constant: -10),
            bottomImageLabel.leftAnchor.constraint(equalTo: bottomImageView.leftAnchor, constant: 10),
            bottomImageLabel.rightAnchor.constraint(equalTo: bottomImageView.rightAnchor, constant: -10)
        ])
    }
    
}
