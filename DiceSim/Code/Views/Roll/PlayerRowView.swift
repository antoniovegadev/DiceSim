//
//  PlayerRowView.swift
//  DiceSim
//
//  Created by Antonio Vega on 9/1/21.
//

import SwiftUI

struct PlayerRowView: View {
    @ObservedObject var player: Player

    var body: some View {
        HStack {
            Circle()
                .foregroundColor(Color(player.playerColor))
                .frame(width: 18, height: 18)
//                .padding()

            Text(player.playerName)

            Spacer()
        }
    }
}

struct PlayerRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerRowView(player: Player.example)
            .previewLayout(.fixed(width: 300, height: 50))
    }
}
