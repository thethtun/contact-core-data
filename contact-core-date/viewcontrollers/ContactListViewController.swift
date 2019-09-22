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

    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewContactList.dataSource = self
        tableViewContactList.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
//        testCoreData()
    }
   
    
    
    fileprivate func testCoreData() {
        
//        insertRefrigerator()
        
//        if let result = getRefrigeratorByName(name : "Nintendo") {
//            print(result.name ?? 0)
//
//            if let fruits = fetchFruitsByRefrigerator(refrigerator: result) {
//                fruits.forEach{ fruit in
//                    print(fruit.name ?? "")
//                }
//            }
//        }
    }
    
    fileprivate func fetchFruitsByRefrigerator(refrigerator : Refrigerator) -> [Fruit]? {
        let fetchRequest : NSFetchRequest<Fruit> = Fruit.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "refrigerator == %@", refrigerator)
        
        if let fruits = try? persistentContainer.viewContext.fetch(fetchRequest) {
            return fruits
        }
        
        return nil
    }
    
    
    fileprivate func insertRefrigerator() {
        //        /*
        //         INSERT name INTO Refrigerator VALUES ("Samsung");
        //         */
        
        let c = Refrigerator(context: persistentContainer.viewContext)
        c.name = "Nintendo"
        let fruit = Fruit(context: persistentContainer.viewContext)
        fruit.name = ""
        c.addToFruits(fruit)
        c.addToFruits(Fruit(context: persistentContainer.viewContext))
        
        //        let fruit = Fruit(context: persistentContainer.viewContext)
        //        fruit.name = "apple"
        //        fruit.color = "red"
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save data \(error.localizedDescription)")
        }
    }
    
    
    fileprivate func getRefrigeratorByName(name : String) -> Refrigerator? {
        /*
         SELECT * FROM Refrigerator WHERE name = "Samsung";
         */
        let fetchRequest : NSFetchRequest<Refrigerator> = Refrigerator.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            return results[0]
        } catch {
            print("Failed to fetch data \(error.localizedDescription)")
            return nil
        }
    }
    
    fileprivate func getAllRefigerator () {
        /*
         SELECT *  FROM Refrigerator ORDER BY name ASC;
         */
        let fetchRequest : NSFetchRequest<Refrigerator> = Refrigerator.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            print("=====================")
            results.forEach{ result in
                print(result.name ?? "Empty name")
                
                try? persistentContainer.viewContext.delete(result)
                
            }
            print("=====================")
            
            
        } catch {
            print("Failed to fetch data \(error.localizedDescription)")
        }
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

