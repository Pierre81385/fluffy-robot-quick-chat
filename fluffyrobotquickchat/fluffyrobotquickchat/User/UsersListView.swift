//
//  UsersAllView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//

import SwiftUI

struct UsersListView: View {
    
    @State var user: UserDoc = UserDoc(email: "", name: "")
    @ObservedObject private var userModel = UserModel.init(userDocs: [], user: UserDoc(email: "", name: ""), errorMessage: "")
    
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
                userModel.fetchUserDocs()
            }
    }
}

struct UsersListView_Preview: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
