//
//  ContentView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RollView()
                .tabItem {
                    Image(systemName: "die.face.6.fill")
                    Text("Roll")
                }
            
            HistoryListView()
                .tabItem {
                    Image(systemName: "book.closed.fill")
                    Text("History")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
