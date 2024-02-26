//
//  UserDetail.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/5/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct UserMain: View {
    @State var logout: Bool = false
    @State var allUsers: Bool = false
    @State var allItems: Bool = false
    @State var allRooms: Bool = false
    @State var selection: Int = 0
    @State var currentUser: User?

    @ObservedObject private var userModel = UserModel.init(userProfiles: [], userProfile: UserProfile(email: "", name: "", image: "", birthday: Date(), online: false, role: Role.Owner, friends: []), errorMessage: "", successStatus: false)
    
    var body: some View {
        ZStack {
           
            
            TabView {
                UserProfileView(currentUser: currentUser, currentUserProfile: userModel.userProfile)
                    .tabItem {
                        Image(systemName: "person")
                        Text("My Profile")
                    }
                    .tag(0)
                UsersListView(currentUser: currentUser, userProfiles: userModel.userProfiles)
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Message")
                    }
                    .tag(1)
                RoomListView()
                    .tabItem {
                        Image(systemName: "person.3.sequence.fill")
                        Text("Group Chat")
                    }
                    .tag(2)
                ItemListView()
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard")
                        Text("Orders")
                    }
                    .tag(3)
                
            }.tint(.black)
        }
        .onAppear{
            currentUser = Auth.auth().currentUser
            userModel.fetchUserProfile(documentId: (currentUser?.email)!)
            userModel.fetchUserProfiless()
                   }
        }
    }

#Preview {
    UserMain()
}
