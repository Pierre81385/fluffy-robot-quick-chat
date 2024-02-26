//
//  RoomListView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/2/24.
//

import Foundation
import SwiftUI

struct RoomListView: View {
    @State var newRoom: Bool = false
    @ObservedObject private var room: RoomModel = RoomModel.init(rooms: [], room: Room(name: "", description: "", createdBy: "", isPrivate: false, users: []), errorMessage: "")
        
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    newRoom = true
                }, label: {
                    Text("+ Room")
                }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                    .padding()
                    .navigationDestination(isPresented: $newRoom, destination: {RoomBuilder()})
                NavigationView {
                    List(room.rooms) {
                        room in
                        
                        NavigationLink(destination: {ChatView(thisRoom: room)}, label: {Text(room.name)})
                        
                    }
                }
                    .onAppear {
                        room.fetchRooms()
                    }
                
            }.tint(.black)
        }
    }
}

struct RoomListView_Preview: PreviewProvider {
    static var previews: some View {
        RoomListView()
    }
}
