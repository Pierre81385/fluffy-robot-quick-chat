//
//  UsersAllView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//

import SwiftUI

struct UsersListView: View {
    
    @ObservedObject private var userModel = UserModel()
    
    var body: some View {
        NavigationView {
            List(userModel.userDocs) {
                user in
                VStack {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                }
            }
        }.navigationTitle("Users")
            .onAppear {
                userModel.fetchUserDocument()
            }
    }
}

struct UsersListView_Preview: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
