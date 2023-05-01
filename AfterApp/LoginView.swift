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
    
    var body: some View {
        VStack {
            Image("AfterLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
            Text("Login")
                .font(.largeTitle)
                .padding(.bottom, 50)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            Button(action: {
                print("Username: \(username)")
                print("Password: \(password)")
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding(.bottom, 30)
        }
        .padding()
        .background(Color("darkGray"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
