//
//  WatchDetailTableViewCell.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class DetailBodyTableViewCell: UITableViewCell {
    
    var showDescription = false
    
    var detailTypeTitleText: String? = ""
    var detailTypeValueText: String? = "-"
    var descriptionText: String? = ""
    
    
    private lazy var detailTypeTitleLabel: UILabel = {
        let detailTypeTitleLabel = UILabel()
        detailTypeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTypeTitleLabel.font = UIFont.systemFont(ofSize: 13)
        detailTypeTitleLabel.textColor = .gray
        return detailTypeTitleLabel
    }()
    
    private lazy var detailTypeValueLabel: UILabel = {
        let detailTypeValueLabel = UILabel()
        detailTypeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTypeValueLabel.font = UIFont.systemFont(ofSize: 13)
        detailTypeValueLabel.textColor = .gray
        return detailTypeValueLabel
    }()
    
    private lazy var descriptionTextView: UITextView = {
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
        setupCell()
    }
    
    func setupCell() {
        if showDescription {
            setupDescriptionTextView()
        } else { setupDetailLabels() }
    }
    
    private func setupDescriptionTextView() {
        self.addSubview(descriptionTextView)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        descriptionTextView.attributedText = NSAttributedString(string: descriptionText ?? "", attributes: [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 12)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            descriptionTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            descriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
        
    }
    
    private func setupDetailLabels() {
        self.addSubview(detailTypeTitleLabel)
        self.addSubview(detailTypeValueLabel)
        
        guard let detailTypeTitleText = detailTypeTitleText, let detailTypeValueText = detailTypeValueText else {return}
        
        detailTypeTitleLabel.text = detailTypeTitleText
        detailTypeValueLabel.text = ": \(detailTypeValueText)"
        
        NSLayoutConstraint.activate([
            detailTypeTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            detailTypeTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            detailTypeTitleLabel.rightAnchor.constraint(equalTo: detailTypeValueLabel.leftAnchor, constant: 8),
            detailTypeTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            detailTypeTitleLabel.widthAnchor.constraint(equalToConstant: 80),
            
            
            detailTypeValueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            detailTypeValueLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            detailTypeValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
        ])
    }
    
}
