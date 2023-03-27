//
//  WatchDetailHeaderView.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

protocol DetailSubtitleProtocol {
    func onIsLikedButtonSelected()
}

class DetailSubtitleView: UIView {
    
    var delegate: DetailSubtitleProtocol?
    
    private lazy var labelButtonStackView: UIStackView = {
       let labelButtonStackView = UIStackView()
        labelButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        labelButtonStackView.distribution = .fill
        labelButtonStackView.alignment = .center
        return labelButtonStackView
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Detail Product"
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return subtitleLabel
    }()
    
    private lazy var isLikedButton: UIButton = {
        let isLikedButton = UIButton(type: .system)
        isLikedButton.translatesAutoresizingMaskIntoConstraints = false
        
        let defaultImage = UIImage(systemName: "heart")
        isLikedButton.setImage(defaultImage, for: .normal)
        isLikedButton.tintColor = .black
        
        NSLayoutConstraint.activate([
            isLikedButton.widthAnchor.constraint(equalToConstant: 24),
            isLikedButton.heightAnchor.constraint(equalTo: isLikedButton.widthAnchor)
        ])
        
        isLikedButton.addTarget(self, action: #selector(onIsLikedButtonSelected), for: .touchUpInside)
        
        return isLikedButton
    }()
    
    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.backgroundColor = .black
        return separatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupComponentsConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setupComponentsConstraints()
    }

    func setupDetailSubTitle(isLiked: Bool) {
        let isLikedImage = UIImage(systemName: isLiked ?
                                   "heart.fill" : "heart")
        isLikedButton.setImage(isLikedImage, for: .normal)
    }
    
    @objc func onIsLikedButtonSelected(_ sender: UIButton) {
        delegate?.onIsLikedButtonSelected()
    }
    
    private func addSubviews() {
        self.addSubview(labelButtonStackView)
        labelButtonStackView.addArrangedSubview(subtitleLabel)
        labelButtonStackView.addArrangedSubview(isLikedButton)
        self.addSubview(separatorView)
    }
    
    private func setupComponentsConstraints() {
        NSLayoutConstraint.activate([
            labelButtonStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            labelButtonStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            labelButtonStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            
            separatorView.topAnchor.constraint(equalTo: labelButtonStackView.bottomAnchor, constant: 5),
            separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            separatorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
