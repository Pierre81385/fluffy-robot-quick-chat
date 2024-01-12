import SwiftUI

struct RegisterView: View {
    @State var email: String = "";
    @State var password: String = "";
    
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
                        print("submit")
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
