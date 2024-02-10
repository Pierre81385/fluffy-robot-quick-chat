//
//  ChatView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/8/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ChatView: View {
    var thisRoom: Room
    var unixtime: Double = Date().timeIntervalSince1970
    @State var currentUser: User?
    @State var compose: String = ""
    @State var sent: Bool = false
    @ObservedObject private var userModel = UserModel.init(userDocs: [], user: UserDoc(email: "", name: ""), errorMessage: "")
    @ObservedObject private var room = RoomModel(rooms: [], room: Room(name: "", description: "", createdBy: "", isPrivate: false, users: []), errorMessage: "")
    @ObservedObject private var message = MessageModel(message: Message(senderName: "", senderId: "", sendTime: 0.0, message: "", read: false, readTime: 0.0))
    
    var body: some View {
        ZStack {
            Color(Color.offWhite)
            VStack {
                Text(thisRoom.name)
                Text(thisRoom.description)
                Text(thisRoom.createdBy)
//                NavigationView {
//                    List(thisRoom.users) {
//                        user in
//                        NavigationLink(destination: Text("ChatView")) {
//                            VStack {
//                                
//                                Text(user.name)
//                                    .font(.headline)
//                                Text(user.email)
//                            }
//                        }
//                        .navigationTitle("All Users")
//                        
//                    }
//                }
                List(message.messages) {
                    message in
                    VStack {
                        Text(message.senderName)
                        Text(message.message)
                    }
                }
                HStack {
                    TextField("", text: $compose)
                        .accentColor(.black)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
                        .padding()
                    Button(action: {
                        let composedMessage: Message = Message(senderName: userModel.user.name, senderId: userModel.user.id, sendTime: unixtime, message: compose, read: false, readTime: 0)
                        message.addMessage(message: composedMessage, documentId: thisRoom.id!)
                        compose = ""
                    }, label: {
                        Text(">")
                    }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                }
            }
        }.onAppear{
            message.fetchMessages(documentId: thisRoom.id!)
            currentUser = Auth.auth().currentUser
            userModel.fetchUserDoc(documentId: currentUser!.email ?? "")
        }.ignoresSafeArea()
    }
    
}

//struct ChatView_Preview: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
