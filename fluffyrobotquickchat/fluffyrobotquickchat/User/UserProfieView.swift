//
//  UserProfie.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI
//a view to show a card with the user profile on it

struct UserProfileView: View {
    @State var user: StoredUser = StoredUser(email: "pjb.den@gmail.com", password: "")
    @State var status: FirestoreStatus = FirestoreStatus(success: false, code: 100, message: "")
    
    var body: some View {
        ZStack {
            if (status.success) {
                VStack {
                    Text(status.message)
                    Text(user.email)
                    Text(user.password)
                }
            } else {
                VStack {
                    Text("ERROR")
                    Text(status.message)
                }
            }
        }.onAppear {
            let firestore = FirestoreUser(user: $user, status: $status)
            firestore.getUser()
        }
            
    }
}

#Preview {
    UserProfileView()
}
