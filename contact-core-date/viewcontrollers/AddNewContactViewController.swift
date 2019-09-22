//
//  AddNewContactViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit
import CoreData

class AddNewContactViewController: UIViewController {

    @IBOutlet weak var textFieldUserName : UITextField!
    @IBOutlet weak var stackViewAddPhone : UIStackView!
    @IBOutlet weak var stackViewAddEmail : UIStackView!
    @IBOutlet weak var stackViewAddAddress : UIStackView!
    @IBOutlet weak var navigationBar : UINavigationBar!
    
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
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
        
        let contactVO = ContactVO(context: persistentContainer.viewContext)
        contactVO.username = username
        
        
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
            .forEach { (value) in
                let data = PhoneNumberVO(context: persistentContainer.viewContext)
                data.number = value
                data.contact = contactVO
            }

        stackViewAddEmail.arrangedSubviews.map { (view) -> UITextField? in
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
            .forEach { (value) in
                let data = EmailVO(context: persistentContainer.viewContext)
                data.address = value
                data.contact = contactVO
        }

        stackViewAddAddress.arrangedSubviews.map { (view) -> UITextField? in
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
            .forEach { (value) in
                let data = AddressVO(context: persistentContainer.viewContext)
                data.fullAddress = value
                data.contact = contactVO
        }
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            Dialog.showAlert(viewController: self, title: "Error", message: "Failed to save contact \(error.localizedDescription)")
        }
        
        if isEditingMode {
            self.onContactUpdated!(contactVO)
        } else {
            self.onNewContactAdded!(contactVO)
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    
    func showEditingMode() {
        navigationBar.topItem?.title = "Edit Contact"
    }
    
    func inflateExistingDataForEditMode(data : ContactVO) {
        textFieldUserName.text = data.username
        
//        data.phoneNumbers.forEach { (data) in
//            let textField = WidgetGenerator.getUITextField(contentType: .creditCardNumber)
//            textField.text = data.number
//            stackViewAddPhone.insertArrangedSubview(textField, at: 0)
//        }
//
//        data.emails.forEach { (data) in
//            let textField = WidgetGenerator.getUITextField(contentType: .emailAddress)
//            textField.text = data.address
//            stackViewAddEmail.insertArrangedSubview(textField, at: 0)
//        }
//
//        data.addresses.forEach { (data) in
//            let textField = WidgetGenerator.getUITextField(contentType: .fullStreetAddress)
//            textField.text = data.fullAddress
//            stackViewAddAddress.insertArrangedSubview(textField, at: 0)
//        }
    }
    
    func showError(message : String?) {
        let controller = UIAlertController.init(title: "error", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            controller.dismiss(animated: true, completion: nil)
        }))
        self.present(controller, animated: true, completion: nil)
    }

}


