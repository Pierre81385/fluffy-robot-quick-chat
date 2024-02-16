//
//  RoomListView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/2/24.
//

import Foundation
import SwiftUI

struct RoomListView: View {
    
    @ObservedObject private var room: RoomModel = RoomModel.init(rooms: [], room: Room(name: "", description: "", createdBy: "", isPrivate: false, users: []), errorMessage: "")
        
    var body: some View {
        VStack {
            NavigationView {
                List(room.rooms) {
                    room in
                   
                        NavigationLink(destination: /*ChatView(thisRoom: room*/ Text("To ChatView")) {
                            VStack {
                                Text(room.name)
                            }
                        }
                        .navigationTitle("Chat Rooms")
                    
                }
            }.navigationTitle("Rooms")
                .onAppear {
                    room.fetchRooms()
                }
            
        }.tint(.black)
    }
}

struct RoomListView_Preview: PreviewProvider {
    static var previews: some View {
        RoomListView()
    }
}
