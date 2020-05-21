 //
 //  UpdateContactView.swift
 //  ContactSwiftUI
 //
 //  Created by Thet Htun on 5/22/20.
 //  Copyright © 2020 thethtun. All rights reserved.
 //
 
 import SwiftUI
 
 struct UpdateContactView: View {
    
    var userContact : UserContact
    @Binding var isPresented : Bool
    @State private var showAlert : Bool = false
    @State var userName : String
    @State var phoneNumberStates : [PhoneNumberVO]
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
                    Divider()
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                Spacer()
            }.padding(.top, 15)
                .navigationBarTitle("Edit Contact", displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.isPresented.toggle()
                    }, label: {
                        Text("Cancel")
                    }), trailing:
                    Button(action: {
                        self.updateContact()
                    }, label: {
                        Text("Done")
                    }).alert(isPresented: $showAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
            )
        }
    }
    
    
    private func updateContact() {
        if userName.isEmpty {
            self.alertMessage = "Please enter user name"
            self.showAlert = true
        } else if phoneNumberStates.isEmpty {
            self.alertMessage = "Please enter phone numbers"
            self.showAlert = true
        } else {
            //TODO: Need to check if phone number fields are empty
            
            let contactVO = ContactVO(
                name: userName,
                phoneNumbers: phoneNumberStates)
            
            //save data
            let db = DatabaseManager()
            db.updateUserContact(oldData: self.userContact, newData: contactVO)
            
            //dismiss view
            self.isPresented.toggle()
        }
    }
 }
 
 struct UpdateContactView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateContactView(
            userContact: UserContact(),
            isPresented: .constant(true),
            userName: "",
            phoneNumberStates: [PhoneNumberVO]()
        )
    }
 }
