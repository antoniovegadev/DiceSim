//
//  CreateGameView.swift
//  DiceSim
//
//  Created by Antonio Vega on 9/1/21.
//

import SwiftUI
import CoreData

struct CreateGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataController: DataController

    @ObservedObject var game: Game
    @Binding var mode: Mode

    @State private var gameTitle = ""

    var body: some View {
        Form {
            Section(header: Text("Game")) {
                TextField("Game Title", text: $gameTitle)
            }

            Section(header: Text("Players")) {
                ForEach(game.gamePlayers) { player in
                    NavigationLink(destination: EditPlayerView(player: player, playerCount: game.gamePlayers.count)) {
                        PlayerRowView(player: player)
                    }
                }

                if game.gamePlayers.count < 4 {
                    Button("Add Player") {
                        withAnimation {
                            dataController.addPlayer(to: game)
                        }
                    }
                }
            }
        }
        .navigationTitle("Create Game")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    mode = .menu
                    dataController.delete(game)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Start") {
                    game.title = gameTitle
                    game.datePlayed = Date()
                    dataController.save()
                    mode = .game
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct CreateGameView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        NavigationView {
            CreateGameView(game: Game.createExample, mode: .constant(Mode.game))
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
