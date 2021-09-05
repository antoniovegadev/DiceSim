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
            Label(
                title: { Text(player.playerName) },
                icon: {
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color(player.playerColor))
                }
            )

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
