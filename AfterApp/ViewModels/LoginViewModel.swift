//
//  LoginViewModel.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 20.8.23.
//

import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
}
