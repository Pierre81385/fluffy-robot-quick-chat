import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class UserModel: ObservableObject {
    @Published var userDocs = [UserDoc]()
    @Published var user: UserDoc
    @Published var errorMessage: String?
    
    init(userDocs: [UserDoc] = [UserDoc](), user: UserDoc, errorMessage: String) {
        self.userDocs = userDocs
        self.user = user
        self.errorMessage = errorMessage
    }
    
    private var db = Firestore.firestore()
    
    func addUser(user: UserDoc) {
      let collectionRef = db.collection("users")
        let documentRef = collectionRef.document(user.email)
      do {
          try documentRef.setData(from: user)
          print("User stored with new document ID: \(user.email)")
      }
      catch {
        print(error)
      }
    }
    
     func fetchUserDock(documentId: String) {
      let docRef = db.collection("users").document(documentId)
      
      docRef.getDocument(as: UserDoc.self) { result in
        switch result {
        case .success(let user):
          self.user = user
        case .failure(let error):
            self.errorMessage = "Error decoding document: \(error.localizedDescription)"
        }
      }
    }
    
    func updateUser(user: UserDoc, documentId: String) {
        let docRef = db.collection("user").document(documentId)
        do {
          try docRef.setData(from: user)
        }
        catch {
          print(error)
        }
      }
    
    
    func deleeteUser(documentId: String) async {
        let docRef = db.collection("users").document(documentId)
        
        do {
          try await docRef.delete()
          print("Document successfully removed!")
        } catch {
          print("Error removing document: \(error)")
        }
        
    }
    
    func fetchUserDocs() {
        db.collection("users")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.userDocs = documents.compactMap { queryDocumentSnapshot -> UserDoc? in
                    return try? queryDocumentSnapshot.data(as: UserDoc.self)
                }
                print("Got all users!)")
            }
    }
}
