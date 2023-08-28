//
//  LoginView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 2.5.23.
//

import SwiftUI
import RiveRuntime

struct LoginView: View {

    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State var showPassword: Bool = false
    @State private var isAuthenticated: Bool = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center, spacing: 10) {
                    Spacer()
                    Image("AfterLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180.0)
                    Spacer()
                    Text("Sign In")
                        .foregroundColor(Color("AfterBeige"))
                        .font(.headline)
                        .fontWidth(.expanded)
                    TextField("Email", text: $email, prompt: Text("Email").foregroundColor(Color("AfterBeige")))
                        .foregroundColor(Color("AfterBeige"))
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .padding(10)
                        .frame(height: 55)
                        .fontWidth(.expanded)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("AfterBeige"), lineWidth: 1)
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
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("AfterBeige"), lineWidth: 1)
                    }
                    .padding(.horizontal)
                    Spacer()
                    
                    //Sign In Button
                    Button{
                        Task{
                            try await authenticationViewModel.signIn(withEmail: email, password: password)
                        }
//                        isAuthenticated = true
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .fontWidth(.expanded)
                            .foregroundColor(Color("AfterDarkGray"))
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color("AfterBeige"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    //Create Account Button
                    NavigationLink{
                        CreateAccountView()
                    } label: {
                        Text("Create Account")
                            .font(.headline)
                            .fontWidth(.expanded)
                            .foregroundColor(Color("AfterBeige"))
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("AfterBeige"), lineWidth: 2)
                            }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }.background{
                    VStack{
                        RiveViewModel(fileName: "after_start_animation")
                            .view()
                            .padding(.bottom, 450)
                            .frame(width: 400)
                            .opacity(0.3)
                    }
                        
                }
            .background(Color("AfterDarkGray"))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
            LoginView()
                .environmentObject(AuthenticationViewModel())
                .tint(Color("AfterBeige"))
    }
}
