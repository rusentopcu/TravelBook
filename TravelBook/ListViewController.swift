//
//  ListViewController.swift
//  TravelBook
//
//  Created by Rusen Topcu on 10.02.2020.
//  Copyright © 2020 Rusen Topcu. All rights reserved.
//

import UIKit
import  CoreData

class ListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var titleArray = [String]()
    var idArray = [UUID]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
       
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
    }
    
    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func getData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try contex.fetch(fetchRequest)
            if results.count > 0 {
                
                titleArray.removeAll(keepingCapacity: false)
                idArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject] {
                    
                    if let title = result.value(forKey: "title") as? String {
                        titleArray.append(title)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        idArray.append(id)
                    }
                    tableView.reloadData()
                    
                }
            
            }
            
        }
        catch {
            print("error")
        }
        
        
    }

}
