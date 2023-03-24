//
//  WatchDetailTableViewCell.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class WatchDetailTableViewCell: UITableViewCell {
    
    var showIsLikedButton = false
    var showDescription = false
    
    var typeDetailText: String?
    var detailProductText: String?
    var isLiked: Bool?
    
    
    var typeDetailLabel: UILabel = {
        let typeDetailLabel = UILabel()
        typeDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        typeDetailLabel.font = UIFont.systemFont(ofSize: 12)
        typeDetailLabel.textColor = .gray
        return typeDetailLabel
    }()
    
    var detailProductLabel: UILabel = {
        let detailProductLabel = UILabel()
        detailProductLabel.translatesAutoresizingMaskIntoConstraints = false
        detailProductLabel.font = UIFont.systemFont(ofSize: 12)
        detailProductLabel.textColor = .gray
        return detailProductLabel
    }()
    
    var isLikedButton: UIButton = {
        let isLikedButton = UIButton()
        isLikedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        isLikedButton.translatesAutoresizingMaskIntoConstraints = false
        isLikedButton.tintColor = .black
        return isLikedButton
    }()
    
    var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = false
        descriptionTextView.isScrollEnabled = false
        return descriptionTextView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell() {
        self.addSubview(typeDetailLabel)
        self.addSubview(detailProductLabel)
//        self.addSubview(isLikedButton)
        self.addSubview(descriptionTextView)
        
        if showDescription {
            setupDescriptionTextView()
        } else { setupDetailLabels() }
    }
    
    func setupDescriptionTextView() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        descriptionTextView.attributedText = NSAttributedString(string: detailProductText ?? "", attributes: [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 12)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            descriptionTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            descriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        ])
        
    }
    
    func setupDetailLabels() {
        guard let typeDetailText = typeDetailText, let detailProductText = detailProductText else {return}
        
        typeDetailLabel.text = typeDetailText
        detailProductLabel.text = ": \(detailProductText)"
        
        NSLayoutConstraint.activate([
            typeDetailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            typeDetailLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            typeDetailLabel.rightAnchor.constraint(equalTo: detailProductLabel.leftAnchor),
            typeDetailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            typeDetailLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            
            detailProductLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            detailProductLabel.leftAnchor.constraint(equalTo: typeDetailLabel.rightAnchor, constant: 30),
            //            detailProductLabel.rightAnchor.constraint(equalTo: self.leftAnchor),
            detailProductLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
        ])
        
        if showIsLikedButton {
            self.addSubview(isLikedButton)
            
            NSLayoutConstraint.activate([
                detailProductLabel.rightAnchor.constraint(equalTo: isLikedButton.leftAnchor, constant: 20),
                
                isLikedButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
                //                isLikedButton.leftAnchor.constraint(equalTo: detailProductLabel.rightAnchor, constant: 30),
                isLikedButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -22),
                isLikedButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
                isLikedButton.widthAnchor.constraint(equalToConstant: 24),
                isLikedButton.heightAnchor.constraint(equalToConstant: 24)
            ])
        } else {
            detailProductLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 30).isActive = true
        }
    }
    
}
