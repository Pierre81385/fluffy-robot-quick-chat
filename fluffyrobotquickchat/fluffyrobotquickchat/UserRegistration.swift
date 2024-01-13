import SwiftUI
import FirebaseFirestore



struct RegisterView: View {
    @State var email: String = "";
    @State var password: String = "";
        
    var body: some View {
        ZStack {
            Color(Color.offWhite)
            VStack {
                //email
                TextField("email address", text: $email)
                    .padding()
                //password
                TextField("password", text: $password)
                    .padding()
                //buttons
                HStack {
                    Button(action: {
                        print("back")
                    }, label: {
                        Text("Back")
                    })
                    .buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                        .padding()
                    Button(action: {
                        if (email == "" || password == ""){
                            print("Register error: Form is incomplete.")
                        } else {
                            let user = FirestoreUser()
                            
                            Task {
                                await user.createNewUser(email: email, password: password)
                            }
                        }
                        
                        
                    }, label: {
                        Text("Register")
                        //function to create DB record of users
                        //function to move user to the next screen
                    }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                        .padding()
                }
            }
        }.ignoresSafeArea()
    }
    
}

#Preview {
    RegisterView()
}
