//
//  AddContactView.swift
//  ContactSwiftUI
//
//  Created by Thet Htun on 5/13/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import SwiftUI

struct AddContactView: View {
    
    @Binding var isPresented : Bool
    
    @State private var showAlert : Bool = false
    @State private var userName : String = ""
    @State private var phoneNumberStates = [PhoneNumberVO]()
    @State private var alertTitle: String = "Attention"
    @State private var alertMessage : String = "Error"
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    TextFieldUserName(textFieldName: $userName)
                    ForEach(phoneNumberStates, id: \.id) { (value) in
                        TextFieldPhoneNumber()
                            .environmentObject(value)
                    }
                    
                    AddPhoneActionView(phoneNumberStates: $phoneNumberStates)
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                Spacer()
            }.padding(.top, 15)
                .navigationBarTitle("Add Contact", displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.isPresented.toggle()
                    }, label: {
                        Text("Cancel")
                    }), trailing:
                    Button(action: {
                        self.addContact()
                    }, label: {
                        Text("Done")
                    }).alert(isPresented: $showAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
            )
        }
    }
    
    private func addContact() {
        if userName.isEmpty {
            self.alertMessage = "Please enter user name"
            self.showAlert = true
        } else if phoneNumberStates.isEmpty {
            self.alertMessage = "Please enter phone numbers"
            self.showAlert = true
        } else {
            let contactVO = ContactVO(
                name: userName,
                phoneNumbers: phoneNumberStates)
            
            //save data
            let db = DatabaseManager()
            db.saveUserContact(data: contactVO)
            
            //dismiss view
            self.isPresented.toggle()
        }
        
    }
}


struct AddPhoneActionView : View {
    @Binding var phoneNumberStates : [PhoneNumberVO]
    
    var body : some View {
        HStack(spacing: 15) {
            Image("icons8-add")
                .resizable()    
                .frame(width: 35, height: 35)
            Text("add phone").font(Font.system(size: 15))
            Spacer()
        }.onTapGesture {
            let vo = PhoneNumberVO(number: "")
            self.phoneNumberStates.append(vo)
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(isPresented: .constant(true))
    }
}
