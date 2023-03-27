//
//  ViewController.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import UIKit

class WatchListViewController: UIViewController {
    
    var watchListViewModel: WatchListViewModel?
    
    private lazy var watchListTableView: UITableView = {
        let watchListTablewView = UITableView()
        watchListTablewView.translatesAutoresizingMaskIntoConstraints = false
        watchListTablewView.separatorStyle = .none
        return watchListTablewView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFit
        
        return logoImageView
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        return containerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 1, green: 0.781, blue: 0.802, alpha: 1)
        setupNavigationLogo()
        setupViewModel()
        setupTableView()
        setupContainerView()
    }

    private func setupNavigationLogo() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: logoImageView)
    }
    
    private func setupContainerView() {
        self.view.addSubview(containerView)
        self.view.sendSubviewToBack(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: watchListTableView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    private func setupViewModel() {
        watchListViewModel = WatchListViewModel()
        watchListViewModel?.delegate = self
        watchListViewModel?.getWatchList()
    }

    private func setupTableView() {
        view.addSubview(watchListTableView)
        
        watchListTableView.delegate = self
        watchListTableView.dataSource = self
        watchListTableView.separatorStyle = .none
        
        watchListTableView.register(WatchListTableViewCell.self, forCellReuseIdentifier: "WatchListTableViewCell")
        
        NSLayoutConstraint.activate([
            watchListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            watchListTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            watchListTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            watchListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8),
        ])
    }
}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchListViewModel?.watchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let watch = watchListViewModel?.watchList?[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as? WatchListTableViewCell else {return UITableViewCell()}
        
        cell.watch = watch
        cell.delegate = self
        cell.setupCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension WatchListViewController: WatchListDelegate {
    func onGetWatchCompleted() {
        DispatchQueue.main.async {
            self.watchListTableView.reloadData()
        }
    }
}

extension WatchListViewController: WatchListTableCellDelegate {
    func onWatchCellClicked(on watch: Watch) {
        let watchDetailVC = WatchDetailViewController()
        watchDetailVC.productId = watch.id
        watchDetailVC.productName = watch.name
        navigationController?.pushViewController(watchDetailVC, animated: true)
        
//        let storyboard = UIStoryboard(name: "StuffStoryboard", bundle: nil)
//        guard let stuffVC = storyboard.instantiateViewController(withIdentifier: "StuffViewController") as? StuffViewController else {return}
//        navigationController?.pushViewController(stuffVC, animated: true)
    }
    
    
}
