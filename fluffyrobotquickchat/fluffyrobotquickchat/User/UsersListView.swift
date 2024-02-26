//
//  UsersAllView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//

import SwiftUI
import FirebaseAuth

struct UsersListView: View {
    
    var currentUser: User?
    var userProfiles: [UserProfile]
    
    var body: some View {
        NavigationView {
            List(userProfiles) {
                user in
                if(user.email != currentUser?.email){
                    VStack {
                        NavigationLink(destination: Text("ChatView")) {
                            HStack {
                                Text(user.name)
                                    .font(.headline)
                                Spacer()
                                if(user.online){
                                    Image(systemName: "person.fill")
                                }else{
                                    Image(systemName: "person.slash")
                                }
                            }
                        }
                        
                    }
                }
                
            }
        }
    }
}

//struct UsersListView_Preview: PreviewProvider {
//    static var previews: some View {
//        UsersListView()
//    }
//}
