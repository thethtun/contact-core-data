//
//  AddNewContactViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewContactViewController: UIViewController {

    @IBOutlet weak var textFieldUserName : UITextField!
    @IBOutlet weak var stackViewAddPhone : UIStackView!
    @IBOutlet weak var stackViewAddEmail : UIStackView!
    @IBOutlet weak var stackViewAddAddress : UIStackView!
    @IBOutlet weak var navigationBar : UINavigationBar!
    
    var editingContactId : String = ""
    
    var onNewContactAdded : ((ContactVO) -> Void)?
    var onContactUpdated : ((ContactVO) -> Void)?
    var onViewLoaded : (() -> Void)?
    
    var isEditingMode : Bool = false
    
    let realm = try! Realm()
    
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

        var contactRef : ContactVO?
        if !editingContactId.isEmpty {
            let contacts = realm.objects(ContactVO.self).filter(NSPredicate(format: "id == %@", editingContactId))
            if contacts.isEmpty {
                Dialog.showAlert(viewController: self, title: "Error", message: "Can't update data. Try inserting new contact.")
                return
            } else {
                contactRef = contacts.first
            }
        } else {
            contactRef = ContactVO()
        }
        
        guard let safeContactRef = contactRef else {
            Dialog.showAlert(viewController: self, title: "Error", message: "Oops. Something went wrong. Try clear the app or clean install app.")
            return
        }
        
        
        let phoneNumberList = getAddedPhoneNumbers()
        let emailList = getAddedEmails()
        let addressList = getAddedAddresses()
        
        do {
            try realm.write() {
                
                safeContactRef.username = username
                
                safeContactRef.phoneNumbers.removeAll()
                phoneNumberList.forEach{ safeContactRef.phoneNumbers.append($0)}
                
                safeContactRef.emails.removeAll()
                emailList.forEach{ safeContactRef.emails.append($0)}
                
                safeContactRef.addresses.removeAll()
                addressList.forEach{ safeContactRef.addresses.append($0)}

                realm.add(safeContactRef, update: .modified)

            }
        } catch {
            Dialog.showAlert(viewController: self, title: "Error", message: "Failed to save contact \(error.localizedDescription)")
        }
        
        if isEditingMode {
            self.onContactUpdated!(safeContactRef)
        } else {
            self.onNewContactAdded!(safeContactRef)
        }
        
        
        
        self.dismiss(animated: true, completion: nil)
    }

    
    func showEditingMode() {
        navigationBar.topItem?.title = "Edit Contact"
    }
    
    func inflateExistingDataForEditMode(data : ContactVO) {
        textFieldUserName.text = data.username
        
        data.phoneNumbers.forEach { (data) in
            let textField = WidgetGenerator.getUITextField(contentType: .creditCardNumber)
            textField.text = data.number
            stackViewAddPhone.insertArrangedSubview(textField, at: 0)
        }

        data.emails.forEach { (data) in
            let textField = WidgetGenerator.getUITextField(contentType: .emailAddress)
            textField.text = data.address
            stackViewAddEmail.insertArrangedSubview(textField, at: 0)
        }

        data.addresses.forEach { (data) in
            let textField = WidgetGenerator.getUITextField(contentType: .fullStreetAddress)
            textField.text = data.fullAddress
            stackViewAddAddress.insertArrangedSubview(textField, at: 0)
        }
    }
    
    func getAddedPhoneNumbers() -> [PhoneNumberVO] {
        return stackViewAddPhone.arrangedSubviews.map { (view) -> UITextField? in
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
            .map { (value) -> PhoneNumberVO in
                let data = PhoneNumberVO()
                data.number = value
                return data
        }
    }
    
    func getAddedEmails() -> [EmailVO] {
        return stackViewAddEmail.arrangedSubviews.map { (view) -> UITextField? in
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
            .map { (value) -> EmailVO in
                let data = EmailVO()
                data.address = value
                return data
        }
    }
    
    func getAddedAddresses() -> [AddressVO] {
        return stackViewAddAddress.arrangedSubviews.map { (view) -> UITextField? in
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
            .map { (value) -> AddressVO in
                let data = AddressVO()
                data.fullAddress = value
                return data
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


