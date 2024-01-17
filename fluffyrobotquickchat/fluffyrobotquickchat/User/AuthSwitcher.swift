//
//  AuthSwitcher.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/16/24.
//

import SwiftUI
import FirebaseAuth

struct AuthSwitcher: View {
    @State var authComplete: Bool = false;
    @State var user: User?
    
    var body: some View {
        if (authComplete) {
            UserProfileView(user: user)
        } else {
            UserLoginView(user: $user, authComplete: $authComplete)
        }
    }
}
