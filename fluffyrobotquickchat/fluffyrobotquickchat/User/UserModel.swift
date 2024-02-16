import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class UserModel: ObservableObject {
    @Published var userProfiles = [UserProfile]()
    @Published var userProfile: UserProfile
    @Published var errorMessage: String?
    @Published var successStatus: Bool
    
    init(userProfiles: [UserProfile] = [UserProfile](), userProfile: UserProfile, errorMessage: String, successStatus: Bool) {
        self.userProfiles = userProfiles
        self.userProfile = userProfile
        self.errorMessage = errorMessage
        self.successStatus = successStatus
    }
    
    private var db = Firestore.firestore()
    
    func addUserProfile(userProfile: UserProfile) {
      let collectionRef = db.collection("users")
        let documentRef = collectionRef.document(userProfile.email)
      do {
          try documentRef.setData(from: userProfile)
          self.errorMessage = "New user profile stored!"
          self.successStatus = true
          print("User stored with new document ID: \(userProfile.email)")
      }
      catch {
          self.errorMessage = "Error creating document: \(error.localizedDescription)"
          self.successStatus = false
          print(error)
      }
    }
    
     func fetchUserProfile(documentId: String) {
      let docRef = db.collection("users").document(documentId)
      
      docRef.getDocument(as: UserProfile.self) { result in
        switch result {
        case .success(let userProfile):
          self.userProfile = userProfile
            self.successStatus = true
            self.errorMessage = "Got user profile!"
        case .failure(let error):
            self.errorMessage = "Error decoding document: \(error.localizedDescription)"
            self.successStatus = false
        }
      }
    }
    
    func updateUserProfile(userProfile: UserProfile, documentId: String) {
        let docRef = db.collection("users").document(documentId)
        do {
          try docRef.setData(from: userProfile)
            self.successStatus = true
            self.errorMessage = "Document updated!"
        }
        catch {
            self.errorMessage = "Error updating document: \(error.localizedDescription)"
            self.successStatus = false
            print(error)
        }
      }
    
    
    func deleeteUserProfile(documentId: String) async {
        let docRef = db.collection("users").document(documentId)
        
        do {
          try await docRef.delete()
            self.successStatus = true
            self.errorMessage = "Document successfully removed!"
          print("Document successfully removed!")
        } catch {
            self.errorMessage = "Error removing document: \(error.localizedDescription)"
            self.successStatus = false
            print("Error removing document: \(error)")
        }
        
    }
    
    func fetchUserProfiless() {
        db.collection("users")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    self.errorMessage = "Error getting documents: \(error!.localizedDescription)"
                    self.successStatus = false
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.userProfiles = documents.compactMap { queryDocumentSnapshot -> UserProfile? in
                    return try? queryDocumentSnapshot.data(as: UserProfile.self)
                }
                print("Got all user profiles!)")
                self.successStatus = true
                self.errorMessage = "Found user profiles!"
            }
    }
}
