//
//  WatchDetailViewController.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class WatchDetailViewController: UIViewController {
    
    var watchDetail: Watch?
    
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
        setupTableView()
    }
    
    func setupViewController() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
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
            return 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let watch = self.watchDetail else {return UITableViewCell()}
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchImageTableViewCell", for: indexPath) as? WatchImageTableViewCell else {return UITableViewCell()}
            
            cell.setupCell()
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NamePriceTableViewCell", for: indexPath) as? NamePriceTableViewCell else {return UITableViewCell()}
            
            cell.name = watch.name
            cell.price = watch.price
            cell.setupCell()
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchDetailTableViewCell", for: indexPath) as? WatchDetailTableViewCell else {return UITableViewCell()}
            
            switch indexPath.row {
            case 0:
                cell.showIsLikedButton = true
                cell.typeDetailText = "Stock"
                cell.detailProductText = "20"
            case 1:
                cell.typeDetailText = "Size"
                cell.detailProductText = "-"
            case 2:
                cell.typeDetailText = "Weight"
                cell.detailProductText = "100 gram"
            case 3:
                cell.typeDetailText = "Type"
                cell.detailProductText = "Accessoris"
            case 4:
                cell.typeDetailText = "Description"
                cell.detailProductText = " "
            case 5:
                cell.showDescription = true
                cell.detailProductText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et integer turpis fermentum pulvinar adipiscing accumsan, dignissim viverra. Quisque hendrerit ac ipsum, malesuada odio netus. Eu, mauris ullamcorper neque ullamcorper arcu. Amet, condimentum adipiscing enim eu feugiat feugiat pharetra, tristique. Interdum ipsum amet, a nec. Fermentum in viverra suscipit at at sit. Metus condimentum augue erat."
            default:
                break
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
