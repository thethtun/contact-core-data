//
//  ViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit
import RealmSwift


class ContactListViewController: UIViewController {
    
    @IBOutlet weak var tableViewContactList : UITableView!

    ///Migration
    let realm = try! Realm(configuration: Realm.Configuration(
        schemaVersion: 10,
        migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 10) {
                migration.enumerateObjects(ofType: ContactVO.className(), { oldObject, newObject in
                })
            }
            
    }))
    
    var contactList : Results<ContactVO>?
    var contactListToken : NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        
        loadData()
    }
    
    private func initView() {
        tableViewContactList.dataSource = self
        tableViewContactList.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    private func loadData() {
        contactList = realm.objects(ContactVO.self).sorted(byKeyPath: "createdAt", ascending: true)
        
        //Observing Collection data changes
        contactListToken = contactList?.observe{ [weak self] (changes : RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self?.tableViewContactList.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                //Query results have changed, so apply them to the UITableView
                self?.tableViewContactList.beginUpdates()
                // Always apply updates in the following order: deletions, insertions, then modifications.
                // Handling insertions before deletions may result in unexpected behavior.
                self?.tableViewContactList.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                                      with: .automatic)
                self?.tableViewContactList.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                                      with: .automatic)
                self?.tableViewContactList.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                                      with: .automatic)
                self?.tableViewContactList.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break;
            }
        }
    }
    
    deinit {
        contactListToken?.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = segue.destination as? AddNewContactViewController {
            
//            vc.onNewContactAdded = { [weak self] (data) in
//                self?.contactList?.append(data)
//                self?.tableViewContactList.reloadData()
//            }
            

        } else if let vc = segue.destination as? ContactDetailsViewController {
            if let indexPath = tableViewContactList.indexPathForSelectedRow {
                vc.selectedIndexPath = indexPath
                vc.data = self.contactList![indexPath.row]
//                vc.onContactUpdated = { [weak self] (data) in
//                    self?.contactList![indexPath.row] = data
//                    self?.tableViewContactList.reloadData()
//                }
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
        return contactList?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        cell.data = contactList?[indexPath.row]
        
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
        ///Delete Object Using Realm Delete
        try! realm.write {
            realm.delete(self.contactList![indexPath.row])
        }
        
        tableViewContactList.deleteRows(at: [indexPath], with: .automatic)
    }
}

