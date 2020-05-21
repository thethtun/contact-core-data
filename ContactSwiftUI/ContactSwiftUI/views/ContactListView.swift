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
            List {
                ForEach(contacts, id: \.id) { (data: UserContact) in
                    NavigationLink(destination: ContactDetailsView(data: data)) {
                        ContactListCell(data: data)
                    }
                }.onDelete { (index) in
                    self.deleteContact(at: index)
                }
            }
            .navigationBarTitle("Contacts")
            .navigationBarItems(leading:
                EditButton()
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
    
    func deleteContact(at offsets: IndexSet) {
        if !contacts.isEmpty {
            let deletingContact = contacts[(offsets.first) ?? 0]
            
            //Delete From Db
            DatabaseManager().deleteUserContact(data: deletingContact)
        }
    }
  
}

struct ContactListCell: View {
    
    let data : UserContact
    
    var body : some View {
        HStack(spacing: 10) {
            ZStack {
                Color.random
                    .clipShape(Circle())
                Text(String((data.name ?? "??").first ?? "A").capitalized)
                    .font(Font.system(size: 20))
                    .foregroundColor(.white)
                
            }.frame(width: 50, height: 50)
            Text(data.name ?? "???")
        }
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
