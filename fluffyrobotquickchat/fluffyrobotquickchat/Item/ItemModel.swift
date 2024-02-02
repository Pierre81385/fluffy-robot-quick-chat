//
//  ItemViewModel.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//

import SwiftUI
import FirebaseFirestore

class ItemModel: ObservableObject {
    @Published var items = [Item]()
    @Published var item: Item
    @Published var errorMessage: String?
    
    init(items: [Item] = [Item](), item: Item, errorMessage: String) {
        self.items = items
        self.item = item
        self.errorMessage = errorMessage
    }
    
    private var db = Firestore.firestore()
    
    func addItem(item: Item) {
      let collectionRef = db.collection("items")
        let documentRef = collectionRef.document()
      do {
          try documentRef.setData(from: item)
          print("Item stored with new document ID: \(String(describing: item.id))")
      }
      catch {
        print(error)
      }
    }
    
    func fetchItem(documentId: String) {
     let docRef = db.collection("items").document(documentId)
     
     docRef.getDocument(as: Item.self) { result in
       switch result {
       case .success(let item):
         self.item = item
       case .failure(let error):
           self.errorMessage = "Error decoding document: \(error.localizedDescription)"
       }
     }
   }
    
    func updateItem(item: Item, documentId: String) {
        let docRef = db.collection("items").document(documentId)
        do {
          try docRef.setData(from: item)
        }
        catch {
          print(error)
        }
      }
    
    
    func deleeteItrem(documentId: String) async {
        let docRef = db.collection("items").document(documentId)
        
        do {
          try await docRef.delete()
          print("Document successfully removed!")
        } catch {
          print("Error removing document: \(error)")
        }
        
    }
    
    func fetchItems() {
        db.collection("items")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.items = documents.compactMap { queryDocumentSnapshot -> Item? in
                    return try? queryDocumentSnapshot.data(as: Item.self)
                }
                print("Got all users!)")
            }
    }
}
