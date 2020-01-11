//
//  ViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController, AddNewContactViewControllerDelegate {
    
    @IBOutlet weak var tableViewContactList : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewContactList.dataSource = self
        tableViewContactList.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableViewContactList.setEditing(editing, animated: animated)
    }

    func onNewContactAdded(_ data: ContactVO) {
        tempContactList.append(data)
        self.tableViewContactList.reloadData()
    }
    
    func onContactUpdated(_ data: ContactVO) {
        tempContactList = tempContactList.map { (contact) -> ContactVO in
            if(contact.username == data.username) {
                return data
            }
            return contact
        }
    }
    
    @IBAction func onClickAddNewContact(_ sender : Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewContactViewController") as! AddNewContactViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailsViewController") as! ContactDetailsViewController
        vc.selectedIndexPath = indexPath
        vc.data = tempContactList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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

