//
//  ContactDetailsView.swift
//  ContactSwiftUI
//
//  Created by Thet Htun on 5/22/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import SwiftUI

struct ContactDetailsView: View {
    
    let data : UserContact
    
    @State private var showEditContactView: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Phone Numbers")
                ForEach((data.phone_numbers?.allObjects as! [UserPhoneNumber]), id : \.id) { (item : UserPhoneNumber) in
                    LabelPhoneNumberItem(phoneNumber: item.number ?? "0000")
                }
                Divider()
                Spacer()
            }.padding()
            
            Spacer()
        }
        .navigationBarTitle(data.name ?? "???")
        .navigationBarItems(trailing:
            Button(action: {
                self.showEditContactView.toggle()
            }, label : {
                Text("Edit")
            }).sheet(isPresented: $showEditContactView) {
                UpdateContactView(
                    userContact: self.data,
                    isPresented: self.$showEditContactView,
                    userName: self.data.name ?? "",
                    phoneNumberStates: (self.data.phone_numbers?.allObjects.map({ (item) -> PhoneNumberVO? in
                        guard let obj = item as? UserPhoneNumber else {
                            return nil
                        }
                        return PhoneNumberVO(id : obj.id ?? "", number: obj.number ?? "")
                    }) ?? [PhoneNumberVO]()).compactMap{$0} )
            }
        )
    }
}

struct LabelPhoneNumberItem : View {
    
    let phoneNumber : String
    
    var body : some View {
        Button(action: {
            let formattedString = "tel://\(self.phoneNumber)"
            guard let url = URL(string: formattedString) else { return }
            UIApplication.shared.open(url)
        }) {
            Text(phoneNumber)
                .font(Font.system(size: 25, weight: .light, design: .default))
        }
    }
}

struct ContactDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailsView(data : UserContact())
    }
}
