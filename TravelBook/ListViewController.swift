//
//  ListViewController.swift
//  TravelBook
//
//  Created by Rusen Topcu on 10.02.2020.
//  Copyright © 2020 Rusen Topcu. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
       
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test"
        return cell
    }

}
