//
//  ContactDetailsViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit
import CoreData

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var stackViewPhoneNumbers : UIStackView!
    @IBOutlet weak var stackViewEmails : UIStackView!
    @IBOutlet weak var stackViewAddress : UIStackView!
    
    var selectedIndexPath : IndexPath?
    var onContactUpdated : ((ContactVO) -> Void)?
    
    var data : ContactVO?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onClickEditDetails) )
        // Do any additional setup after loading the view.
        guard let data = data else {
            print("contact data is nil")
            return
        }
       
        bindDetails(data: data)
        
    }
    
    func bindDetails(data : ContactVO) {
        
        navigationItem.title = data.username
        
        stackViewPhoneNumbers.removeAllArrangeSubViews()
        
        let fetchRequest : NSFetchRequest<PhoneNumberVO> =  PhoneNumberVO.fetchRequest()
        let predicate = NSPredicate(format: "contact == %@", data)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let result = try? DataController.shared.viewContext!.fetch(fetchRequest) {
            result.forEach { (vo) in
                let label = WidgetGenerator.getUILabelContactDetails()
                label.text = vo.number
                stackViewPhoneNumbers.addArrangedSubview(label)
            }
        }
        
        
//        stackViewEmails.removeAllArrangeSubViews()
//        data.emails.forEach { (vo) in
//            let label = WidgetGenerator.getUILabelContactDetails()
//            label.text = vo.address
//            stackViewEmails.addArrangedSubview(label)
//        }
//
//        stackViewAddress.removeAllArrangeSubViews()
//        data.addresses.forEach { (vo) in
//            let label = WidgetGenerator.getUILabelContactDetails()
//            label.text = vo.fullAddress
//            stackViewAddress.addArrangedSubview(label)
//        }
    }
    
    @objc func onClickEditDetails(_ sender : Any) {
        performSegue(withIdentifier: "abc", sender: sender)
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let vc = segue.destination as? AddEditContactViewController {
            vc.isEditingMode = true
            vc.onViewLoaded = { [weak self] in
                vc.inflateExistingDataForEditMode(data: self!.data!)
            }
            vc.onContactUpdated = { [weak self] (data) in
                self?.data = data
                self?.bindDetails(data: self?.data ?? ContactVO())
                self?.onContactUpdated!(data)
            }
        }
        
    }
    

   

}


extension UIStackView {
    func removeAllArrangeSubViews() {
        arrangedSubviews.forEach { (view) in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
