//
//  WatchDetailViewController.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class WatchDetailViewController: UIViewController {
    
    var watchId: Int?
    var watchDetailViewModel: WatchDetailViewModel?
    
    let watchDetailTableView: UITableView = {
        let watchDetailTableView = UITableView()
        watchDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        return watchDetailTableView
    }()
    
    let rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem()
        rightBarButtonItem.image = UIImage(named: "Share")
        return rightBarButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewController()
        setupViewModel()
        setupTableView()
    }
    
    func setupViewController() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupViewModel() {
        guard let watchId = watchId else { return }
        watchDetailViewModel = WatchDetailViewModel(watchId: watchId)
        watchDetailViewModel?.delegate = self
        watchDetailViewModel?.getWatchDetail()
    }
    
    func setupTableView() {
        view.addSubview(watchDetailTableView)
        
        watchDetailTableView.register(NamePriceTableViewCell.self, forCellReuseIdentifier: "NamePriceTableViewCell")
        watchDetailTableView.register(WatchImageTableViewCell.self, forCellReuseIdentifier: "WatchImageTableViewCell")
        watchDetailTableView.register(WatchDetailTableViewCell.self, forCellReuseIdentifier: "WatchDetailTableViewCell")
        
        watchDetailTableView.delegate = self
        watchDetailTableView.dataSource = self
        watchDetailTableView.separatorStyle = .none
        watchDetailTableView.sectionHeaderTopPadding = 0
        
        NSLayoutConstraint.activate([
            watchDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            watchDetailTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            watchDetailTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            watchDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension WatchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return 1
        case 2:
            return watchDetailViewModel?.details?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let watch = watchDetailViewModel?.watchDetail?.watch else {return UITableViewCell()}
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchImageTableViewCell", for: indexPath) as? WatchImageTableViewCell else {return UITableViewCell()}
            
            cell.setupCell(imageUrlString: watch.imageUrlString, watchType: watch.category)
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NamePriceTableViewCell", for: indexPath) as? NamePriceTableViewCell else {return UITableViewCell()}
            
            cell.setupCell(watchName: watch.name, watchPrice: watch.priceString)
            
            return cell
            
        case 2:
            guard let detail = watchDetailViewModel?.details?[indexPath.row],
                let cell = tableView.dequeueReusableCell(withIdentifier: "WatchDetailTableViewCell", for: indexPath) as? WatchDetailTableViewCell else {return UITableViewCell()}
            
            if indexPath.row == 0 {
                cell.showIsLikedButton = true
            } else { cell.showIsLikedButton = false }
            
            
            if detail.type == .descriptionBody {
                cell.showDescription = true
                cell.detailProductText = detail.value
            } else {
                cell.showDescription = false
                cell.typeDetailText = detail.type.rawValue
                cell.detailProductText = detail.value
            }
            
            cell.setupCell()
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let watchDetailHeaderView = WatchDetailHeaderView()
            watchDetailHeaderView.setupHeaderView()
            
            return watchDetailHeaderView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 20
        } else {return 0}
    }
}

extension WatchDetailViewController: WatchDetailProtocol {
    func onGetWatchDetailCompleted() {
        DispatchQueue.main.async {
            self.watchDetailTableView.reloadData()
        }
    }
}
