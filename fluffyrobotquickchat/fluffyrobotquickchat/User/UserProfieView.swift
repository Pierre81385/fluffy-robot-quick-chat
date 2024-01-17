//
//  UserProfie.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
    var user: User?
    @State var newRoom: Bool = false
    
    var body: some View {
        ZStack {
            Color(Color.offWhite)
            VStack {
                Text("User Profile")
                //Text(user!.uid)
                Button(action: {
                    newRoom = true
                }, label: {
                    Text("+ Chatroom")
                })
                .sheet(isPresented: $newRoom, content: {
                    CreateChatRoomView()
                }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                    .padding()
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    UserProfileView()
}
