//
//  UserProfie.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
    var user: User?
    @State var newRoom: Bool = false
    
    var body: some View {
        ZStack {
            Color(Color.offWhite)
            VStack {
                //avatarURL
                Text("User Profile")
                //Text(user!.uid)
                //display name
                //email
                //phone number
                
                
            }
        }.ignoresSafeArea()
    }
}

struct UserProfileView_Preview: PreviewProvider {
    static var previews: some View {
        UserProfileView()
  }
}
