import SwiftUI
import FirebaseFirestore

struct RegisterView: View {
    @State var email: String = "";
    @State var password: String = "";
    
    let db = Firestore.firestore()
    
    func createUser () async{
        do {
          try await db.collection("users").document().setData([
            "email": email,
            "password": password,
          ])
          print("Document successfully written!")
        } catch {
          print("Error writing document: \(error)")
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                //email
                TextField("email address", text: $email)
                //password
                TextField("password", text: $password)
                //buttons
                HStack {
                    Button(action: {
                        print("back")
                    }, label: {
                        Text("Back")
                    })
                    Button(action: {
                        Task {
                            await createUser()
                        }
                    }, label: {
                        Text("Submit")
                        //function to create DB record of users
                        //function to move user to the next screen
                    })
                }
            }
        }
    }
    
}

#Preview {
    RegisterView()
}
