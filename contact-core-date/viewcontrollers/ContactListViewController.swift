//
//  ViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewController: UIViewController {

    @IBOutlet weak var tableViewContactList : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let fetchRequest : NSFetchRequest<ContactVO> = ContactVO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let context = DataController.shared.viewContext {
            if let result = try? context.fetch(fetchRequest) {
                tempContactList = result
            }
        }
        
        tableViewContactList.dataSource = self
        tableViewContactList.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddEditContactViewController {
            
            vc.onNewContactAdded = { [weak self] (data) in
                tempContactList.insert(data, at: 0)
                self?.tableViewContactList.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                
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
        
        DataController.shared.viewContext!.delete(tempContactList[indexPath.row])
        try? DataController.shared.viewContext?.save()
        
        tempContactList.remove(at: indexPath.row)
        tableViewContactList.deleteRows(at: [indexPath], with: .automatic)
    }
}

