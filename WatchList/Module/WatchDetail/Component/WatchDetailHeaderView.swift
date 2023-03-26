//
//  WatchDetailHeaderView.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class WatchDetailHeaderView: UITableViewHeaderFooterView {
    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Detail Product"
        title.font = UIFont.boldSystemFont(ofSize: 14)
        return title
    }()
    
    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.backgroundColor = .black
        return separatorView
    }()

    func setupHeaderView() {
        self.addSubview(title)
        self.addSubview(separatorView)
        
        setupComponentsConstraints()
    }
    
    private func setupComponentsConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 30),
            
            
            separatorView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            separatorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
