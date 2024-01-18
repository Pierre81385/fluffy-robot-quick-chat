//
//  ChatRoom.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/14/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Combine


struct AddChatRoomView: View {
    @State var room: StoredChatroom = StoredChatroom(createdBy: "pjb.den@gmail.com", roomName: "", roomDescription: "", isPrivate: true, code: 0, users: [], messages: [])
    @State var status: FirebaseStatus = FirebaseStatus(success: false, code: 100, message: "")
    @State var dig1: String = "5"
    @State var dig2: String = "5"
    @State var dig3: String = "5"
    @State var dig4: String = "5"
    @State var dig5: String = "5"
    @State var dig6: String = "5"
    @State var user: User?
  
    let roler1 = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let roler2 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let roler3 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let roler4 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let roler5 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let roler6 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]


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
                
                    Toggle(isOn: $room.isPrivate) {
                        Text("Private?")
                    }.padding()
                    .tint(.black)
                if(room.isPrivate) {
                    ZStack {
                        VStack {
                            Text("SELECT ROOM CODE")
                            HStack {
                                Picker("Select a number", selection: $dig1) {
                                    ForEach(roler1, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.wheel)
                                
                                Picker("Select a number", selection: $dig2) {
                                    ForEach(roler2, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.wheel)
                                
                                Picker("Select a number", selection: $dig3) {
                                    ForEach(roler3, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.wheel)
                                Picker("Select a number", selection: $dig4) {
                                    ForEach(roler4, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.wheel)
                                
                                Picker("Select a number", selection: $dig5) {
                                    ForEach(roler5, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.wheel)
                                
                                
                                Picker("Select a number", selection: $dig6) {
                                    ForEach(roler6, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.wheel)
                                
                            }.accentColor(.black)
                                
                            
                        }
                    }.NeumorphicStyle()
                        .padding()
                }
                Button(action: {
                    if(room.isPrivate) {
                        let code = "\(dig1)\(dig2)\(dig3)\(dig4)\(dig5)\(dig6)"
                        room.code = Int(code) ?? 0
                    }
                    let firestore = FirestoreChat(room: $room, status: $status)
                    Task {
                        await firestore.createNewChatRoom()
                    }
                }, label: {
                    Text("Create Room")
                }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10))).padding()
            }
        }.ignoresSafeArea()
            .onAppear(perform: {
                room.createedBy = Auth.auth().currentUser!.uid
                room.users.append(Auth.auth().currentUser!.uid)
                
            })
    }
}

#Preview {
    AddChatRoomView()
}
