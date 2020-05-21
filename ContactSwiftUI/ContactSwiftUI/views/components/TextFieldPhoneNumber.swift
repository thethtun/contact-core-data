//
//  TextFieldPhoneNumber.swift
//  ContactSwiftUI
//
//  Created by Thet Htun on 5/22/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import SwiftUI

struct TextFieldPhoneNumber : View {
    
    @EnvironmentObject var obj : PhoneNumberVO
    
    var body : some View {
        TextField("Phone Number", text: $obj.number)
            .font(Font.system(size: 15))
            .textContentType(.telephoneNumber)
            .keyboardType(.phonePad)
            .frame(height: 50)
            .padding([.leading, .trailing], 10)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray)
                .opacity(0.5))
        
        
    }
}

struct TextFieldPhoneNumber_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldPhoneNumber()
    }
}
