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
                .frame(width: 100)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, 5)
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundColor(Color("AfterBeige"))
                .padding(.top, 30)
            
            Text("Hey, \(authenticationViewModel.currentUser?.name ?? "Name") \(authenticationViewModel.currentUser?.surname ?? "Surname")!")
                .foregroundColor(Color("AfterBeige"))
                .font(Font.custom("Shrikhand-Regular", size: 24))
            
            Text("Email: \(authenticationViewModel.currentUser?.email ?? "Email")")
                .foregroundColor(Color("AfterBeige"))
                .fontWidth(.expanded)
            
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
                    .fontWidth(.expanded)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
            
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
