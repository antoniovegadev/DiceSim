//
//  Roll-CoreDataHelpers.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/31/21.
//

import Foundation

extension Roll {
    var rollDate: Date {
        date ?? Date()
    }

    var game: Game {
        player?.game ?? Game()
    }

    var rollPlayer: Player {
        player ?? Player()
    }

    static var example: Roll {
        let dataController = DataController.preview

        let player = Player.example

        let roll = Roll(context: dataController.container.viewContext)
        roll.id = UUID()
        roll.die1 = Int16.random(in: 1...6)
        roll.die2 = Int16.random(in: 1...6)
        roll.date = Date()
        roll.player = player
        
        return roll
    }
}
