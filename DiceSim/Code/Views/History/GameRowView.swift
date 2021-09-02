//
//  GameRowView.swift
//  DiceSim
//
//  Created by Antonio Vega on 9/1/21.
//

import SwiftUI

struct GameRowView: View {
    let game: Game

    var body: some View {
        HStack {
            Text(game.gameTitle)
                .font(.title)

            Spacer()
        }
    }
}

struct GameRowView_Previews: PreviewProvider {
    static var previews: some View {
        GameRowView(game: Game.example)
            .previewLayout(.fixed(width: 300, height: 75))
    }
}
