//
//  MessageModel.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/4/24.
//

import Foundation
import FirebaseFirestore

class MessageModel: ObservableObject {
    @Published var messages = [Message]()
    @Published var message: Message
    @Published var errorMessage: String?
    
    init(messages: [Message] = [Message](), message: Message, errorMessage: String? = nil) {
        self.messages = messages
        self.message = message
        self.errorMessage = errorMessage
    }
    
    private var db = Firestore.firestore()
    
    func addMessage(message: Message, documentId: String) {
        let collectionRef = db.collection("rooms").document(documentId).collection("messages")
        let documentRef = collectionRef.document()
        do {
            try documentRef.setData(from: message)
            print("Message stored with in \(documentId): \(String(describing: message.id))")
        }
        catch {
          print(error)
        }
    }
    
    func fetchMessage(documentId: String) {
        let collectionRef = db.collection("rooms").document(documentId).collection("messages")
        let documentRef = collectionRef.document(documentId)
        
        documentRef.getDocument(as: Message.self) {
            result in switch result {
            case .success(let message):
                self.message = message
            case .failure(let error):
                self.errorMessage = "Error decoding documenbt: \(error.localizedDescription)"
            }
        }
    }
    
    func updateMessage(message: Message, documentId: String) {
        let collectionRef = db.collection("rooms").document(documentId).collection("messages")
        let documentRef = collectionRef.document(documentId)
        do {
          try documentRef.setData(from: message)
        }
        catch {
          print(error)
        }
      }
    
    
    func deleeteMessage(documentId: String) async {
        let collectionRef = db.collection("rooms").document(documentId).collection("messages")
        let documentRef = collectionRef.document(documentId)
        do {
          try await documentRef.delete()
          print("Document successfully removed!")
        } catch {
          print("Error removing document: \(error)")
        }
        
    }
    
    func fetchMessages(documentId: String) {
        db.collection("rooms").document(documentId).collection("messages").order(by: "sendTime", descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.messages = documents.compactMap { queryDocumentSnapshot -> Message? in
                    return try? queryDocumentSnapshot.data(as: Message.self)
                }
                print("Got all messages!)")
            }
    }
    
}
