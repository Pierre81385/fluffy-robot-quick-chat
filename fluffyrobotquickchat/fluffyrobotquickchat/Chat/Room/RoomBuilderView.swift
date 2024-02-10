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
    @State var name: String = ""
    @State var description: String = ""
    @State var isPrivate: Bool = false
    @ObservedObject private var userModel = UserModel.init(userDocs: [], user: UserDoc(email: "", name: ""), errorMessage: "")
    @ObservedObject private var room = RoomModel(rooms: [], room: Room(name: "", description: "", createdBy: "", isPrivate: false, users: []), errorMessage: "")
    
    var body: some View {
        ZStack {
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
                    let newRoom = Room(name: name, description: description, createdBy: userModel.user.email, isPrivate: isPrivate, users: [UserDoc(email: userModel.user.email, name: userModel.user.name)])
                    room.addRoom(room: newRoom)
                }, label: {
                    Text("SUBMIT")
                })
            }
        }.onAppear{
            userModel.fetchUserDoc(documentId: (currentUser?.email)!)
        }
    }
}

#Preview {
    RoomBuilder()
}
