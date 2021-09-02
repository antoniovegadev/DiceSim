//
//  GameDetailView.swift
//  DiceSim
//
//  Created by Antonio Vega on 9/1/21.
//

import SwiftUI
import CoreData

struct GameDetailView: View {
    let game: Game

    var body: some View {
        List {
            ForEach(game.gameRolls) { roll in
                GameRollView(roll: roll)
            }
        }
        .navigationTitle(game.gameTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameDetailView(game: Game.example)
        }
    }
}
