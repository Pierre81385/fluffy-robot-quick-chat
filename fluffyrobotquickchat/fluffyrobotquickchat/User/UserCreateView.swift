//
//  UserCreateView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/16/24.
//

import SwiftUI

struct UserCreateView: View {
    var userProfile: UserProfile?
    @ObservedObject private var user = UserModel.init(userProfiles: [], userProfile: UserProfile(email: "", name: "", image: "", birthday: Date(), about: "",role: Role.Owner, friends: []), errorMessage: "", successStatus: false)
    @ObservedObject var auth = FireAuth(authStatus: false, authErrorMessage: "")
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    UserCreateView()
}
