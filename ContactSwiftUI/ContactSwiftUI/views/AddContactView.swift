//
//  AddContactView.swift
//  ContactSwiftUI
//
//  Created by Thet Htun on 5/13/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import SwiftUI

struct AddContactView: View {
    
    @State private var textFieldName = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                TextFieldUserName(textFieldName: $textFieldName)
                AddPhoneActionView()
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
            Spacer()
        }
        .navigationBarTitle("Add Contact", displayMode: .inline)
        .padding([.top], 15)
    }
}

struct TextFieldUserName : View {
    @Binding var textFieldName : String
    
    var body : some View {
        TextField("User Name", text: $textFieldName)
            .frame(height: 50)
            .padding([.leading, .trailing], 10)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray)
                .opacity(0.5), alignment: .center)
    }
}

struct AddPhoneActionView : View {
    var body : some View {
        HStack(spacing: 15) {
            Image("icons8-add")
                .resizable()
                .frame(width: 35, height: 35)
            Text("add phone").font(Font.system(size: 15))
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
