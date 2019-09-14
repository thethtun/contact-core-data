//
//  ViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    @IBOutlet weak var tableViewContactList : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewContactList.dataSource = self
        tableViewContactList.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddNewContactViewController {
            
            vc.onNewContactAdded = { [weak self] (data) in
                tempContactList.append(data)
                self?.tableViewContactList.reloadData()
            }
            

        } else if let vc = segue.destination as? ContactDetailsViewController {
            if let indexPath = tableViewContactList.indexPathForSelectedRow {
                vc.selectedIndexPath = indexPath
                vc.data = tempContactList[indexPath.row]
                vc.onContactUpdated = { [weak self] (data) in
                    tempContactList[indexPath.row] = data
                }
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableViewContactList.setEditing(editing, animated: animated)
    }


}

extension ContactListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempContactList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.data = tempContactList[indexPath.row]
        
        return cell
    }
}



extension ContactListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteContact(at : indexPath)
        default:()
        }
    }
    
    func deleteContact(at indexPath : IndexPath) {
        tempContactList.remove(at: indexPath.row)
        tableViewContactList.reloadData()
    }
}

