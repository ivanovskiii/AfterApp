//
//  ContentView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 21.8.23.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel

    var body: some View {
        Group{
            if authenticationViewModel.userSession !=  nil{
                AlbumListView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthenticationViewModel())
    }
}
