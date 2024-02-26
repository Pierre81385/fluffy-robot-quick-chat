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
    @ObservedObject private var userModel = UserModel.init(userProfiles: [], userProfile: UserProfile(email: "", name: "", image: "", birthday: Date(), online: false, role: Role.Owner, friends: []), errorMessage: "", successStatus: false)    
    @ObservedObject private var room = RoomModel(rooms: [], room: Room(name: "", description: "", createdBy: "", isPrivate: false, users: []), errorMessage: "")
    @ObservedObject private var message = MessageModel(message: Message(senderName: "", senderId: "", sendTime: 0.0, message: "", read: false, readTime: 0.0))
    
    var body: some View {
        ZStack {
            Color(Color.white)
            VStack {
                Text(thisRoom.name)
                Text(thisRoom.description)
                
                List(message.messages) {
                    message in
                    if(message.senderName != userModel.userProfile.name){
                       
                            HStack {
                                VStack.init(alignment: .leading) {
                                    Text(message.senderName).font(.headline)
                                    Text(message.message)
                                }
                                .rotationEffect(.radians(.pi))
                                .scaleEffect(x: -1, y: 1, anchor: .center)
                                Spacer()
                            }
                        
                    } else {
                        
                            HStack {
                                Spacer()
                                VStack.init(alignment: .trailing) {
                                    Text(message.senderName).font(.headline)
                                    Text(message.message)
                                }
                                .rotationEffect(.radians(.pi))
                                .scaleEffect(x: -1, y: 1, anchor: .center)
                            
                        }
                    }
                }
                .rotationEffect(.radians(.pi))
                .scaleEffect(x: -1, y: 1, anchor: .center)

                HStack {
                    TextField("", text: $compose)
                        .accentColor(.black)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
                        .underlineTextField()
                        .padding()
                    Button(action: {
                        let composedMessage: Message = Message(senderName: userModel.userProfile.name, senderId: userModel.userProfile.id, sendTime: unixtime, message: compose, read: false, readTime: 0)
                        message.addMessage(message: composedMessage, documentId: thisRoom.id!)
                        compose = ""
                    }, label: {
                        Text(">")
                    }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                }.padding()
            }
        }.onAppear{
            message.fetchMessages(documentId: thisRoom.id!)
            currentUser = Auth.auth().currentUser
            userModel.fetchUserProfile(documentId: (currentUser?.email)!)
        }
    }
    
}

//struct ChatView_Preview: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
