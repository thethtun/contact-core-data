//
//  ContactListView.swift
//  ContactSwiftUI
//
//  Created by Thet Htun on 5/13/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import SwiftUI

struct ContactListView: View {
    
    @State private var showAddNewContact : Bool = false
    @FetchRequest(
        entity: UserContact.entity(),
        sortDescriptors: [NSSortDescriptor(key: "created_at", ascending: false)]
    ) var contacts: FetchedResults<UserContact>
    
    var body: some View {
        NavigationView {
            List(contacts, id: \.id) { (data: UserContact) in
                Text(data.name ?? "???")
            }
            .navigationBarTitle("Contacts")
            .navigationBarItems(leading:
                NavigationLink(destination: AddContactView(isPresented: $showAddNewContact), label: {
                    Text("Edit")
                })
                , trailing:
                Button(action: {
                    self.showAddNewContact.toggle()
                }, label: {
                    Image(systemName: "plus")
                }).sheet(isPresented: $showAddNewContact, content: {
                    AddContactView(isPresented: self.$showAddNewContact)
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
