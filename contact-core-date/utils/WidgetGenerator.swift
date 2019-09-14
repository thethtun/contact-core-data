//
//  WidgetGenerator.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation
import UIKit

class WidgetGenerator {
    static func getUITextField(contentType : UITextContentType) -> UITextField {
        let ui = UITextField()
        ui.textContentType = contentType
        ui.borderStyle = .roundedRect
        ui.placeholder = "Enter \(contentType.rawValue)"
        ui.textColor = UIColor.black
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return ui
    }
    
    static func getUILabelContactDetails() -> UILabel {
        let ui = UILabel()
        ui.font = UIFont.systemFont(ofSize: 20)
        ui.numberOfLines = 0
        ui.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        return ui
    }
}
