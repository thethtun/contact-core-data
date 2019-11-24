//
//  AddNewContactViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit
import CoreData

class AddEditContactViewController: UIViewController {
    
    @IBOutlet weak var textFieldUserName : UITextField!
    @IBOutlet weak var stackViewAddPhone : UIStackView!
    @IBOutlet weak var stackViewAddEmail : UIStackView!
    @IBOutlet weak var stackViewAddAddress : UIStackView!
    @IBOutlet weak var navigationBar : UINavigationBar!
    
    private var editingContact : ContactVO?
    private var existingPhoneNumbers : [PhoneNumberVO]?
    
    
    var onNewContactAdded : ((ContactVO) -> Void)?
    var onContactUpdated : ((ContactVO) -> Void)?
    var onViewLoaded : (() -> Void)?
    
    var isEditingMode : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEditingMode {
            showEditingMode()
        }
        
        if let onViewLoaded = onViewLoaded {
            onViewLoaded()
        }
    }
    
    @IBAction func addPhoneNumber(_ sender : Any) {
        let textField = WidgetGenerator.getUITextField(contentType: .creditCardNumber)
        stackViewAddPhone.insertArrangedSubview(textField, at: 0)
    }
    
    @IBAction func addEmail(_ sender : Any) {
        let textField = WidgetGenerator.getUITextField(contentType: .emailAddress)
        stackViewAddEmail.insertArrangedSubview(textField, at: 0)
    }
    
    @IBAction func addAddress(_ sender : Any) {
        let textField = WidgetGenerator.getUITextField(contentType: .fullStreetAddress)
        stackViewAddAddress.insertArrangedSubview(textField, at: 0)
    }
    
    @IBAction func onClickDismiss(_ sender : Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickSave(_ sender : Any) {
        
        guard let username = textFieldUserName.text, !username.isEmpty else {
            showError(message: "Empty username")
            return
        }
        
        //Delete existing phone numbers
        if let phonenumbers = existingPhoneNumbers, !phonenumbers.isEmpty {
            phonenumbers.forEach { (phoneNumberVO) in
                DataController.shared.viewContext!.delete(phoneNumberVO)
            }
        }
        
        //Update existing contact
        var contactRef : ContactVO?
        if let contact = editingContact {
            contactRef = contact
            contact.username = username
            contact.updatedAt = Date()
        } else {
            let contactVO = ContactVO(context: DataController.shared.viewContext!)
            contactVO.username = username
            contactVO.createdAt = Date()
            contactVO.updatedAt = Date()
            contactRef = contactVO
        }
        
        try? DataController.shared.viewContext?.save()
        
        
        stackViewAddPhone.arrangedSubviews.map { (view) -> UITextField? in
            if view is UITextField {
                return view as? UITextField
            }
            return nil
        }.compactMap { $0 }
            .map { (textField) -> String? in
                if textField.text != nil && !textField.text!.isEmpty {
                    return textField.text!
                }
                return nil
        }.compactMap { $0 }
            .forEach { (value)  in
                let vo = PhoneNumberVO(context: DataController.shared.viewContext!)
                vo.number = value
                vo.createdAt = Date()
                vo.updatedAt = Date()
                vo.contact = contactRef
                
                try? DataController.shared.viewContext?.save()
        }
    
        if isEditingMode {
            self.onContactUpdated!(contactRef!)
        } else {
            self.onNewContactAdded!(contactRef!)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showEditingMode() {
        navigationBar.topItem?.title = "Edit Contact"
    }
    
    func inflateExistingDataForEditMode(data : ContactVO) {
        self.editingContact = data
        textFieldUserName.text = data.username
        
        let fetchRequest : NSFetchRequest<PhoneNumberVO> =  PhoneNumberVO.fetchRequest()
        let predicate = NSPredicate(format: "contact == %@", data)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let result = try? DataController.shared.viewContext!.fetch(fetchRequest) {
            existingPhoneNumbers = result
            result.forEach { (data) in
                let textField = WidgetGenerator.getUITextField(contentType: .creditCardNumber)
                textField.text = data.number
                stackViewAddPhone.insertArrangedSubview(textField, at: 0)
            }
        }
        
    }
    
    func showError(message : String?) {
        let controller = UIAlertController.init(title: "error", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            controller.dismiss(animated: true, completion: nil)
        }))
        self.present(controller, animated: true, completion: nil)
    }
    
}


