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
        
        //TODO: Set protocol
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    //TODO: Set editing

    //TODO: implement delegates/protocol
    
    //TODO: on click navigate to AddNewContactViewController
    
    
    //TODO: conform UITableViewDataSource & load ContactTableViewCell
    
    //TODO: conform UITableViewDelegate & implement didSelectRowAt
}

