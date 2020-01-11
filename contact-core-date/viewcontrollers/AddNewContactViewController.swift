//
//  AddNewContactViewController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit

protocol AddNewContactViewControllerDelegate {
    func onNewContactAdded(_ data : ContactVO)
    func onContactUpdated(_ data : ContactVO)
}

class AddNewContactViewController: UIViewController {

    @IBOutlet weak var textFieldUserName : UITextField!
    @IBOutlet weak var stackViewAddPhone : UIStackView!
    @IBOutlet weak var stackViewAddEmail : UIStackView!
    @IBOutlet weak var stackViewAddAddress : UIStackView!
    @IBOutlet weak var navigationBar : UINavigationBar!
    
    var onNewContactAdded : ((ContactVO) -> Void)?
    var onContactUpdated : ((ContactVO) -> Void)?
    var onViewLoaded : (() -> Void)?
    
    var isEditingMode : Bool = false
    
    var delegate : AddNewContactViewControllerDelegate?
    
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
        
        let phoneNumberVOs = stackViewAddPhone.arrangedSubviews.map { (view) -> UITextField? in
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
                let vo = PhoneNumberVO(number: value)
                return vo
            }
        
        let emailVOs = stackViewAddEmail.arrangedSubviews.map { (view) -> UITextField? in
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
                let vo = EmailVO(address: value)
                return vo
        }
        
        
        let addressVOs = stackViewAddAddress.arrangedSubviews.map { (view) -> UITextField? in
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
                let vo = AddressVO(fullAddress: value)
                return vo
        }
        
        
        let contactVO = ContactVO(username: username, phoneNumbers: phoneNumberVOs, emails: emailVOs, addresses: addressVOs)
        
        
        if isEditingMode {
            delegate?.onNewContactAdded(contactVO)
        } else {
            delegate?.onContactUpdated(contactVO)
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
    
    func showError(message : String?) {
        let controller = UIAlertController.init(title: "error", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            controller.dismiss(animated: true, completion: nil)
        }))
        self.present(controller, animated: true, completion: nil)
    }

}


