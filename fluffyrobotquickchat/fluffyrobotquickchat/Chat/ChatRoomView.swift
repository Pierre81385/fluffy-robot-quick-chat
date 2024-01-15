//
//  ChatRoom.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/14/24.
//

import SwiftUI
import FirebaseFirestore

struct ChatRoomView: View {
    @State var room: StoredChatroom = StoredChatroom(createdBy: "pjb.den@gmail.com", roomName: "Peter's Private Room", isPrivate: false, users: [], messages: [])
    @State var status: FirestoreStatus = FirestoreStatus(success: false, code: 100, message: "")
    
    var body: some View {
        ZStack {
            VStack {
                Text("Create Chat Room")
            }
        }.onAppear {
            let firestore = FirestoreChat(room: $room, status: $status)
            Task {
                await firestore.createNewChatRoom(email: "pjb.den@gmail.com")
            }
            
        }
    }
}

#Preview {
    ChatRoomView()
}
