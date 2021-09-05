//
//  Game-CoreDataHelpers.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/31/21.
//

import Foundation

extension Game {
    var gameTitle: String {
        title ?? ""
    }

    var gameDatePlayed: Date {
        datePlayed ?? Date()
    }

    var gamePlayers: [Player] {
        let players = players?.allObjects as? [Player] ?? []
        return players.sorted { $0.playerDateCreated < $1.playerDateCreated }
    }

    var gameRolls: [Roll] {
        var rolls = [Roll]()

        for player in gamePlayers {
            for roll in player.playerRolls {
                rolls.append(roll)
            }
        }

        return rolls.sorted { $0.rollDate > $1.rollDate }
    }

    static var example: Game {
        let dataController = DataController.preview

        let game = Game(context: dataController.container.viewContext)
        game.title = "Board Game"
        game.datePlayed = Date()

        let names = ["Antonio", "Braulio", "Eduardo", "Yajaira"]

        for i in 0..<4 {
            let player = Player(context: dataController.container.viewContext)
            player.name = names[i]
            player.color = Player.colors[i]
            player.game = game
        }

        return game
    }

    static var createExample: Game {
        let dataController = DataController.preview

        let game = Game(context: dataController.container.viewContext)
        game.datePlayed = Date()

        for i in 1...2 {
            let player = Player(context: dataController.container.viewContext)
            player.name = "Player \(i)"
            player.color = Player.colors[i - 1]
            player.game = game
        }

        return game
    }
}
