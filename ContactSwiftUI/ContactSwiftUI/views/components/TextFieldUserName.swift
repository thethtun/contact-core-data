//
//  TextFieldUserName.swift
//  ContactSwiftUI
//
//  Created by Thet Htun on 5/22/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import SwiftUI

struct TextFieldUserName : View {
    @Binding var textFieldName : String
    
    var body : some View {
        TextField("User Name", text: $textFieldName)
            .font(Font.system(size: 15))
            //            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textContentType(.name)
            .frame(height: 50)
            .padding([.leading, .trailing], 10)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray)
                .opacity(0.5))
    }
}

struct TextFieldUserName_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldUserName(textFieldName: .constant(""))
    }
}
