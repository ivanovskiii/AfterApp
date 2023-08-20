//
//  LoginView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 2.5.23.
//

import SwiftUI

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State var showPassword: Bool = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 15) {
            Spacer()
            Image("AfterLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180.0)
                .padding(.leading, CGFloat(90))
                .padding(.bottom, CGFloat(100))
            TextField("Username", text: $username, prompt: Text("Username").foregroundColor(Color("AfterBeige")))
                .foregroundColor(Color("AfterBeige"))
                .padding(10)
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
                    } else{
                        SecureField("Password",
                                    text: $password,
                                    prompt: Text("Password").foregroundColor(Color("AfterBeige"))).foregroundColor(Color("AfterBeige"))
                        
                    }
                }
            }
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("AfterBeige"), lineWidth: 2)
            }
            .padding(.horizontal)
            Spacer()
            
            Button {
              print("do login action")
            } label: {
              Text("Sign In")
              .font(.title2)
              .foregroundColor(Color("AfterDarkGray"))
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color("AfterBeige"))
            .cornerRadius(20)
            .padding()
            
        }
        .background(Color("AfterDarkGray"))
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

//Button { // add this new button
//        showPassword.toggle()
//    } label: {
//        Image(systemName: showPassword ? "eye.slash" : "eye")
//            .foregroundColor(.white)
//    }
