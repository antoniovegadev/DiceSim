//
//  RollView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI

enum Mode: String {
    case menu = "Menu"
    case solo = "Solo"
    case game = "Game"
}

struct RollView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    @State private var mode: Mode = .menu
    @State private var showingChangeToMenuAlert = false
    @State private var showingCreateGameSheet = false
    @State private var newGame: Game? = nil
    
    var body: some View {
        NavigationView {
            Group {
                switch mode {
                case .menu:
                    MenuView(mode: $mode, game: $newGame)
                case .solo:
                    SoloView()
                case .game:
                    GameView()
                }
            }
            .navigationTitle(mode.rawValue)
            .toolbar {
                if mode != .menu {
                    Button("Menu") {
                        showingChangeToMenuAlert = true
                    }
                }
            }
        }
        .alert(isPresented: $showingChangeToMenuAlert) {
            Alert(
                title: Text("Exit?"),
                message: Text("Are you sure you want to quit to menu?"),
                primaryButton: .default(
                    Text("Go to Menu"),
                    action: { mode = .menu }
                ),
                secondaryButton: .cancel()
            )
        }
        .sheet(item: $newGame) { game in
            NavigationView {
                CreateGameView(game: game, mode: $mode)
            }
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
