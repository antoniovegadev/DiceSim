//
//  GameRollView.swift
//  DiceSim
//
//  Created by Antonio Vega on 9/1/21.
//

import SwiftUI

struct GameRollView: View {
    let roll: Roll

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "die.face.\(roll.die1)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundColor(Color(roll.rollPlayer.playerColor))

                Image(systemName: "die.face.\(roll.die2)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundColor(Color(roll.rollPlayer.playerColor))

                Text(roll.rollPlayer.playerName)
                    .font(.title)
            }

            Spacer()

            Text("\(roll.die1 + roll.die2)")
                .font(.title)
        }
    }
}

struct GameRollView_Previews: PreviewProvider {
    static var previews: some View {
        GameRollView(roll: Roll.example)
            .previewLayout(.fixed(width: 300, height: 75))
    }
}
