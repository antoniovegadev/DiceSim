//
//  MenuView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/31/21.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController

    @Binding var mode: Mode
    @Binding var game: Game?

    var body: some View {
        VStack(spacing: 10) {
            Button {
                createGame()
            } label: {
                Text("Game Mode")
            }
            .buttonStyle(AppleButtonStyle(color: .blue))

            Button {
                mode = .solo
            } label: {
                Text("Solo Mode")
            }
            .buttonStyle(AppleButtonStyle(color: .blue))
        }
    }

    func createGame() {
        let game = Game(context: managedObjectContext)
        dataController.addPlayer(to: game)
        dataController.addPlayer(to: game)
        self.game = game
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
//        MenuView(mode: .constant(.menu), createGame: .constant(false))
        MenuView(mode: .constant(.menu), game: .constant(Game()))
    }
}
