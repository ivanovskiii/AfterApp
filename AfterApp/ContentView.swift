//
//  ContentView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 30.4.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack() {
            Image("AfterLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .frame(maxWidth: .infinity, alignment: .top)
            
        }
        .frame(height: 80)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("darkGray"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
