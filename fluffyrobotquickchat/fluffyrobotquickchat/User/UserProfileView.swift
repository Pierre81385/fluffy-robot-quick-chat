//
//  UserProfileView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/24/24.
//

import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
    var currentUser: User?
    var currentUserProfile: UserProfile?
    @State var logout: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(currentUserProfile!.name)
                Text(currentUser!.email ?? "")
                Text(String(describing: currentUserProfile!.role))
                   
                        Button(action: {
                            let firebaseAuth = Auth.auth()
                            do {
                                try firebaseAuth.signOut()
                            } catch let signOutError as NSError {
                                print("Error signing out: %@", signOutError)
                            }
                            logout = true
                        }, label: {
                            Text("Logout")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                            .navigationDestination(isPresented: $logout, destination: {UserLoginView()})
                       
                        
               
            }
        }
    }
}

#Preview {
    UserProfileView()
}
