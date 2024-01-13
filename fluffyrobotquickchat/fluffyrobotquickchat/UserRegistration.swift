import SwiftUI
import FirebaseFirestore



struct RegisterView: View {
    @State var email: String = "";
    @State var password: String = "";
        
    var body: some View {
        ZStack {
            Color(Color.offWhite)
            
            VStack {
                HStack {
                    Text("REGISTRATION")
                        .font(.largeTitle)
                }
                //email
                TextField("email address", text: $email)
                    .accentColor(.black)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                //password
                SecureField("password", text: $password)
                    .accentColor(.black)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                SecureField("verify password", text: $password)
                    .accentColor(.black)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
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
                        Text("Submit")
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
