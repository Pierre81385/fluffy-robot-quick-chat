//
//  RoomModel.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/2/24.
//

import Foundation
import FirebaseFirestore

class RoomModel: ObservableObject {
    @Published var rooms = [Room]()
    @Published var room: Room
    @Published var errorMessage: String?
    
    init(rooms: [Room] = [Room](), room: Room, errorMessage: String? = nil) {
        self.rooms = rooms
        self.room = room
        self.errorMessage = errorMessage
    }
    
    private var db = Firestore.firestore()
    
    func addRoom(room: Room) {
        let collectionRef = db.collection("rooms")
          let documentRef = collectionRef.document()
        do {
            try documentRef.setData(from: room)
            print("Room stored with new document ID: \(String(describing: room.id))")
        }
        catch {
          print(error)
        }
    }
    
    func fetchRoom(documentId: String) {
     let docRef = db.collection("rooms").document(documentId)
     
     docRef.getDocument(as: Room.self) { result in
       switch result {
       case .success(let room):
         self.room = room
       case .failure(let error):
           self.errorMessage = "Error decoding document: \(error.localizedDescription)"
       }
     }
   }
    
    func updateRoom(room: Room, documentId: String) {
        let docRef = db.collection("rooms").document(documentId)
        do {
          try docRef.setData(from: room)
        }
        catch {
          print(error)
        }
      }
    
    
    func deleeteRoom(documentId: String) async {
        let docRef = db.collection("rooms").document(documentId)
        
        do {
          try await docRef.delete()
          print("Document successfully removed!")
        } catch {
          print("Error removing document: \(error)")
        }
        
    }
    
    func fetchRooms() {
        db.collection("rooms")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.rooms = documents.compactMap { queryDocumentSnapshot -> Room? in
                    return try? queryDocumentSnapshot.data(as: Room.self)
                }
                print("Got all rooms!)")
            }
    }
}
