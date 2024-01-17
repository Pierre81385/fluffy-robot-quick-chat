//
//  ChatRoom.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/14/24.
//

import SwiftUI
import FirebaseFirestore

struct CreateChatRoomView: View {
    @State var room: StoredChatroom = StoredChatroom(createdBy: "pjb.den@gmail.com", roomName: "", roomDescription: "", isPrivate: false, code: 0, users: [], messages: [])
    @State var status: FirebaseStatus = FirebaseStatus(success: false, code: 100, message: "")
    
    var body: some View {
        ZStack {
            Color(Color.offWhite)
            VStack {
                TextField("Room Name", text: $room.roomName)
                    .accentColor(.black)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled(true)
                TextField("Description (optional)", text: $room.roomDescription)
                    .lineLimit(10)
                    .accentColor(.black)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled(true)
                Spacer()
                Button(action: {
                    let firestore = FirestoreChat(room: $room, status: $status)
                                Task {
                                    await firestore.createNewChatRoom()
                                }
                }, label: {
                    Text("Create Room")
                }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10))).padding()
            }.padding()
        }.ignoresSafeArea()
    }
}

#Preview {
    CreateChatRoomView()
}
