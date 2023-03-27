//
//  WatchDetailViewController.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

enum WatchDetailSection: Int {
    case header
    case body
}

class WatchDetailViewController: UIViewController {
    
    var productId: Int?
    var productName: String?
    var watchDetailViewModel: WatchDetailViewModel?
    
    private lazy var watchDetailTableView: UITableView = {
        let watchDetailTableView = UITableView()
        watchDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        return watchDetailTableView
    }()
    
    private lazy var shareButton: UIButton = {
        let shareButton = UIButton(type: .system)
        let shareImage = UIImage(named: "Share")
        
        shareButton.setImage(shareImage, for: .normal)
        
        NSLayoutConstraint.activate([
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
        ])
        
        shareButton.addTarget(self, action: #selector(onBackButtonSelected), for: .touchUpInside)
        
        return shareButton
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem()
        return rightBarButtonItem
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .system)
        let backImage = UIImage(systemName: "chevron.left")
        
        backButton.setImage(backImage, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        backButton.contentHorizontalAlignment = .left
        
        backButton.addTarget(self, action: #selector(onBackButtonSelected), for: .touchUpInside)
        
        return backButton
    }()
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let leftBarButtonItem = UIBarButtonItem()
        return leftBarButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavigationBarItems()
        setupViewModel()
        setupTableView()
    }
    
    @objc func onBackButtonSelected(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupNavigationBarItems() {
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftItemsSupplementBackButton = false
        backButton.setTitle(" \(productName ?? "Back")", for: .normal)
        leftBarButtonItem.customView = backButton
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: true)
        
        rightBarButtonItem.customView = shareButton
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
    }
    
    
    private func setupViewModel() {
        guard let productId = productId else { return }
        watchDetailViewModel = WatchDetailViewModel(productId: productId)
        watchDetailViewModel?.delegate = self
        watchDetailViewModel?.getWatchDetail()
    }
    
    private func setupTableView() {
        view.addSubview(watchDetailTableView)
        
        watchDetailTableView.register(DetailHeaderTableViewCell.self, forCellReuseIdentifier: "DetailHeaderTableViewCell")
        watchDetailTableView.register(DetailBodyTableViewCell.self, forCellReuseIdentifier: "DetailBodyTableViewCell")
        
        watchDetailTableView.delegate = self
        watchDetailTableView.dataSource = self
        watchDetailTableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            watchDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            watchDetailTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            watchDetailTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            watchDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension WatchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch WatchDetailSection(rawValue: section) {
        case .header:
            return 1
        case .body:
            return watchDetailViewModel?.details?.count ?? 0
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch WatchDetailSection(rawValue: indexPath.section) {
        case .header:
            guard let watch = watchDetailViewModel?.watchDetail?.watch,
                  let headerCell = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderTableViewCell", for: indexPath) as? DetailHeaderTableViewCell else {return UITableViewCell()}
            
            headerCell.setupCell(
                imageUrlString: watch.imageUrlString,
                productType: watch.category,
                productName: watch.name,
                productPrice: watch.priceString,
                isLiked: watch.isLiked
            )
            
            return headerCell
            
        case .body:
            guard let detail = watchDetailViewModel?.details?[indexPath.row],
                  let bodyCell = tableView.dequeueReusableCell(withIdentifier: "DetailBodyTableViewCell", for: indexPath) as? DetailBodyTableViewCell else {return UITableViewCell()}
            
            if detail.type == .descriptionBody {
                bodyCell.showDescription = true
                bodyCell.descriptionText = detail.value
            } else {
                bodyCell.showDescription = false
                bodyCell.detailTypeTitleText = detail.type.rawValue
                bodyCell.detailTypeValueText = detail.value
            }
            
            bodyCell.setupCell()
            
            return bodyCell
            
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension WatchDetailViewController: WatchDetailProtocol {
    func onGetWatchDetailCompleted() {
        DispatchQueue.main.async {
            self.watchDetailTableView.reloadData()
        }
    }
}
