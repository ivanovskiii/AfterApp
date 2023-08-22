//
//  CreateAccountView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 21.8.23.
//

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State var showPassword: Bool = false
    @State private var isAuthenticated: Bool = false
    @State var name = ""
    @State var surname = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
            VStack (alignment: .center, spacing: 10) {
                Spacer()
                Image("AfterLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180.0)
                Spacer()
                Text("Create New Account")
                    .foregroundColor(Color("AfterBeige"))
                    .font(.headline)
                    .fontWidth(.expanded)
                
                TextField("Name", text: $name, prompt: Text("Name").foregroundColor(Color("AfterBeige")))
                    .foregroundColor(Color("AfterBeige"))
                    .autocorrectionDisabled(true)
                    .padding(10)
                    .fontWidth(.expanded)
                    .frame(height: 55)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                    }
                    .padding(.horizontal)
                
                TextField("Surname", text: $surname, prompt: Text("Surname").foregroundColor(Color("AfterBeige")))
                    .foregroundColor(Color("AfterBeige"))
                    .autocorrectionDisabled(true)
                    .padding(10)
                    .fontWidth(.expanded)
                    .frame(height: 55)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                    }
                    .padding(.horizontal)
                
                TextField("Email", text: $email, prompt: Text("Email").foregroundColor(Color("AfterBeige")))
                    .foregroundColor(Color("AfterBeige"))
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .fontWidth(.expanded)
                    .frame(height: 55)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                    }
                    .padding(.horizontal)
                
                
                HStack{
                    Group{
                        if showPassword{
                            TextField("Password", text: $password,
                                      prompt: Text("Password").foregroundColor(Color("AfterBeige")))
                            .foregroundColor(Color("AfterBeige"))
                            .frame(height: 55)
                            .fontWidth(.expanded)
                        } else{
                            SecureField("Password",
                                        text: $password,
                                        prompt: Text("Password").foregroundColor(Color("AfterBeige"))).foregroundColor(Color("AfterBeige"))
                                .frame(height: 35)
                                .fontWidth(.expanded)
                            
                        }
                    }
                }
                .padding(10)
                .fontWidth(.expanded)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("AfterBeige"), lineWidth: 2)
                }
                .padding(.horizontal)
                Spacer()
                
                //Create Account Button
                Button{
                    Task{
                        try await authenticationViewModel.createAccount(name: name, surname: surname, withEmail: email, password: password)
                    }
                } label: {
                    Text("Create Account")
                        .font(.headline)
                        .fontWidth(.expanded)
                        .foregroundColor(Color("AfterDarkGray"))
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("AfterBeige"))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }.background{
//                RiveViewModel(fileName: "after_start_animation")
//                    .view()
//                    .padding(.bottom, 400)
                    
            }
            .background(Color("AfterDarkGray"))
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
            .environmentObject(AuthenticationViewModel())
    }
}
