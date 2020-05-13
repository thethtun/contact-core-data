//
//  ContactListView.swift
//  ContactSwiftUI
//
//  Created by Thet Htun on 5/13/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import SwiftUI

struct ContactListView: View {
    
    let contacts = [
        ContactData(id: "1", name: "Thet Tun"),
        ContactData(id: "2", name: "Thet Oo"),
    ]
    
    
    
    var body: some View {
        NavigationView {
            List(contacts) { data in
                Text(data.name)
            }
            .navigationBarTitle("Contacts")
            .navigationBarItems(leading:
                NavigationLink(destination: AddContactView(), label: {
                    Text("Edit")
                })
                , trailing:
                NavigationLink(destination: AddContactView(), label: {
                    Image(systemName: "plus")
                })
            )
        }
        
    }
    
    /**
     @State private var showAddNewContact : Bool = false
     Button(action: {
     self.showAddNewContact.toggle()
     }, label: {
     Image(systemName: "plus")
     }).sheet(isPresented: $showAddNewContact, content: {
     AddContactView()
     })
     */
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
