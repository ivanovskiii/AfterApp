//
//  FriendsView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 23.8.23.
//

import SwiftUI

struct FriendsView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State private var isShowingUserListView = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            
            ZStack {
                Text("Friends")
                    .padding()
                    .font(Font.custom("Shrikhand-Regular", size: 24))
                    .foregroundColor(Color("AfterBeige"))
                .padding(.horizontal)
                
                Button{
                    isShowingUserListView.toggle()
                } label: {
                    Image(systemName: "person.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                }
                .padding(.leading, 300)
            }
            .sheet(isPresented: $isShowingUserListView){
                UserListView()
            }
            
            if ((authenticationViewModel.currentUser?.friends.isEmpty) != nil){
                Spacer()
                Text("It seems a bit lonely here...")
                    .padding()
                    .foregroundColor(Color("AfterBeige"))
                    .fontWidth(.expanded)
                    .padding(.horizontal)
                Spacer()
            }

            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .top)
        .background(Color("AfterDarkGray"))
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
