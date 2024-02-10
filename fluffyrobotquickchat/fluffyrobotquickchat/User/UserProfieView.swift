//
//  UserProfie.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UserProfileView: View {
    
    @State var user: UserDoc = UserDoc(email: "", name: "")
    @ObservedObject private var userModel = UserModel.init(userDocs: [], user: UserDoc(email: "", name: ""), errorMessage: "")
    @State var logout: Bool = false
    @State var allUsers: Bool = false
    @State var allItems: Bool = false
    @State var allRooms: Bool = false
    @State var currentUser: User?
    var body: some View {
        NavigationStack{
            ZStack {
                Color(Color.offWhite)
                if(currentUser?.email != nil) {
                    VStack {
                        
                        Text(userModel.user.name)
                        Text(userModel.user.email)
                        
                        Divider().padding()

                        Button(action: {
                            allUsers = true
                        }, label: {
                            Text("Users")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                            .navigationDestination(isPresented: $allUsers, destination: {UsersListView()})
                        Button(action: {
                            allRooms = true
                        }, label: {
                            Text("Chats")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                            .navigationDestination(isPresented: $allRooms, destination: {RoomListView()})
                        Button(action: {
                            allItems = true
                        }, label: {
                            Text("Items")
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                            .padding()
                            .navigationDestination(isPresented: $allItems, destination: {ItemListView()})
                        Divider().padding()

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
                } else {
                    VStack {
                        Text("Loading")
                    }
                }
            }.ignoresSafeArea()
                .onAppear{
                    currentUser = Auth.auth().currentUser
                    userModel.fetchUserDoc(documentId: currentUser!.email ?? "")
                }
        }.accentColor(.black)
    }
}

#Preview {
    UserProfileView()
}
