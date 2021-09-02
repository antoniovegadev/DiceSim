//
//  Player-CoreDataHelpers.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/31/21.
//

import Foundation
import SwiftUI

extension Player {
    static let colors = [
        "Pink",
        "Purple",
        "Red",
        "Orange",
        "Gold",
        "Green",
        "Teal",
        "Light Blue",
        "Dark Blue",
        "Midnight",
        "Dark Gray",
        "Gray"
    ]
    
    var playerName: String {
        name ?? ""
    }

    var playerColor: String {
        color ?? ""
    }

    var playerRolls: [Roll] {
        let rolls = rolls?.allObjects as? [Roll] ?? []
        return rolls
    }

    static var example: Player {
        let dataController = DataController.preview

        let player = Player(context: dataController.container.viewContext)
        player.name = "Antonio"
        player.color = "Pink"

        return player
    }
}
