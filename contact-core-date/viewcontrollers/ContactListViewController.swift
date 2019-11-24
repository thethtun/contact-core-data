//
//  ViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContactListViewController: UIViewController {
    
    @IBOutlet weak var tableViewContactList : UITableView!
    
    let viewModel = ContactListViewModel()
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        
        viewModel.contactList.observeOn(MainScheduler.instance)
            .bind(to: tableViewContactList.rx.items) { tableView, index, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: IndexPath(row: index, section: 0)) as? ContactTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.data = item
                return cell
        }.disposed(by: bag)
        
        
        tableViewContactList.rx.modelSelected(ContactVO.self)
            .subscribe(onNext : { data in
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: String(describing : ContactDetailsViewController.self)) as! ContactDetailsViewController
                vc.data = data
                vc.modalPresentationStyle = .fullScreen
                vc.onContactUpdated = { [weak self] (data) in
                    self?.viewModel.updateContact(data: data)
                }
                self.navigationController?.pushViewController(vc, animated: true)
                
            }).disposed(by: bag)
        
        
        tableViewContactList.rx.itemDeleted
            .subscribe(onNext : { indexPath in
                self.viewModel.deleteContact(data: self.viewModel.getContact(index: indexPath.row))
            }).disposed(by: bag)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddNewContactViewController {
            vc.onNewContactAdded = { [weak self] (data) in
                self?.viewModel.addContact(data: data)
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableViewContactList.setEditing(editing, animated: animated)
    }
    
}


