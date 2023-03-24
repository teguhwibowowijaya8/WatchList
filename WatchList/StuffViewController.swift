//
//  StuffViewController.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 21/02/23.
//

import UIKit

class StuffViewController: UIViewController {

    @IBOutlet weak var stuffTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stuffTableView.delegate = self
        stuffTableView.dataSource = self
    }
}

extension StuffViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StuffTableViewCell", for: indexPath)
        
        cell.textLabel?.text = "TES"
        
        return cell
    }
}
