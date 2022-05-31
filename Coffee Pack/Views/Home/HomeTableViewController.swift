//
//  HomeViewController.swift
//  Coffee Pack
//
//  Created by Hugo Paulista on 29/05/22.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    @IBOutlet var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        homeTableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

}
