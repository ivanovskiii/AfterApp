//
//  UserListView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 28.8.23.
//

import SwiftUI
import FirebaseAuth

struct UserListView: View {
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State private var searchText = ""
    
    var currentUserID: String? {
            authenticationViewModel.currentUser?.id
        }
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return userViewModel.users.filter { user in
                user.id != currentUserID
            }
        } else {
            return userViewModel.users.filter { user in
                user.id != currentUserID && user.username.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Add Friends")
                    .foregroundColor(Color("AfterBeige"))
                    .font(Font.custom("Shrikhand-Regular", size: 24))
                    .padding()
                
                TextField("Search username", text: $searchText)
                    .foregroundColor(Color("AfterBeige"))
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .fontWidth(.expanded)
                    .frame(height: 40)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("AfterBeige"), lineWidth: 1)
                    }
                    .padding(.horizontal)
                
                List(filteredUsers) { user in
                    NavigationLink (destination: UserView(user: user, authenticationViewModel: AuthenticationViewModel()),
                        label: {
                        HStack{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .padding(.trailing, 20)
                            .foregroundColor(Color("AfterBeige"))
                        Text("@\(user.username)")
                            .fontWidth(.expanded)
                            .foregroundColor(Color("AfterBeige"))
                            .frame(height: 40)
                    }})
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
            .background(Color("AfterDarkGray"))
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}

