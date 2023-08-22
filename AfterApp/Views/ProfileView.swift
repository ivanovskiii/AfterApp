//
//  ProfileView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 22.8.23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Image("AfterLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .frame(maxWidth: .infinity, alignment: .top)
            
            Spacer()
            
            Text("Hey, \(authenticationViewModel.currentUser?.name ?? "Name") \(authenticationViewModel.currentUser?.surname ?? "Surname")!")
                .foregroundColor(Color("AfterBeige"))
                .font(.headline)
            
            Text("Email:")
                .foregroundColor(Color("AfterBeige"))
                .font(.headline)
            Text(authenticationViewModel.userSession?.email ?? "Email")
                .foregroundColor(Color("AfterBeige"))
            
            Spacer()
            
            Button{
                authenticationViewModel.signOut()
            } label: {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(Color("AfterDarkGray"))
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color("AfterBeige"))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthenticationViewModel())
    }
}
