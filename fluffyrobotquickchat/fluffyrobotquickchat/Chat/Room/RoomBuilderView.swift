//
//  RoomBuilderView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/2/24.
//

import SwiftUI
import FirebaseAuth

struct RoomBuilder: View {
    var currentUser = Auth.auth().currentUser
    @State var success: Bool = false
    @State var name: String = ""
    @State var description: String = ""
    @State var isPrivate: Bool = false
    @ObservedObject private var userModel = UserModel.init(userProfiles: [], userProfile: UserProfile(email: "", name: "", image: "", birthday: Date(), online: false, role: Role.Owner, friends: []), errorMessage: "", successStatus: false)
    @ObservedObject private var room = RoomModel(rooms: [], room: Room(name: "", description: "", createdBy: "", isPrivate: false, users: []), errorMessage: "")
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    Text("Name")
                    TextField("name", text: $name)
                        .accentColor(.black)
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
                    Text("Description")
                    TextField("description", text: $description)
                        .accentColor(.black)
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
                    Toggle(isOn: $isPrivate) {
                        Text("Private")
                    }.padding()
                        .tint(.black)
                    Button(action: {
                        let newRoom = Room(name: name, description: description, createdBy: userModel.userProfile.email, isPrivate: isPrivate, users: [userModel.userProfile])
                        room.addRoom(room: newRoom)
                        success = true
                    }, label: {
                        Text("SUBMIT")
                    }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                        .padding()
                        .navigationDestination(isPresented: $success, destination: {RoomListView()})
                }
            }.onAppear{
                userModel.fetchUserProfile(documentId: (currentUser?.email)!)
            }
        }
    }
}

#Preview {
    RoomBuilder()
}
