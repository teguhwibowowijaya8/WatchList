//
//  WatchImageTableViewCell.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit
import SkeletonView

class DetailHeaderTableViewCell: UITableViewCell {
    
    private lazy var detailImageView: DetailImageView = {
       let detailImageView = DetailImageView()
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        return detailImageView
    }()
    
    private lazy var detailTitleView: DetailTitleView = {
        let detailTitleView = DetailTitleView()
        detailTitleView.translatesAutoresizingMaskIntoConstraints = false
        return detailTitleView
    }()
    
    private lazy var detailSubtitleView: DetailSubtitleView = {
        let detailSubtitleView = DetailSubtitleView()
        detailSubtitleView.translatesAutoresizingMaskIntoConstraints = false
        return detailSubtitleView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(
        imageUrlString: String,
        productType: String,
        productName: String,
        productPrice: String,
        isLiked: Bool = false
    ) {
        detailImageView.setupDetailImage(with: imageUrlString, productCategory: productType)
        detailTitleView.setupDetailTitle(productName: productName, productPrice: productPrice)
        detailSubtitleView.setupDetailSubTitle(isLiked: isLiked)
        
        addSubviews()
        setupComponentsConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(detailImageView)
        self.addSubview(detailTitleView)
        self.addSubview(detailSubtitleView)
    }
    
    private func setupComponentsConstraints() {
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            detailImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            detailImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            
            
            detailTitleView.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 14),
            detailTitleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 28),
            detailTitleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -28),
            
            
            detailSubtitleView.topAnchor.constraint(equalTo: detailTitleView.bottomAnchor, constant: 10),
            detailSubtitleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            detailSubtitleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            detailSubtitleView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
