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
                Button(action: {
                    newRoom = true
                }, label: {
                    Text("+ Chatroom")
                }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                    .padding()
                    .navigationDestination(isPresented: $newRoom, destination: {AddChatRoomView()})
                
            }
        }.ignoresSafeArea()
    }
}

struct UserProfileView_Preview: PreviewProvider {
    static var previews: some View {
        UserProfileView()
  }
}
