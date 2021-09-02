//
//  DataController.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI
import CoreData

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main", managedObjectModel: Self.model)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }

            #if DEBUG
            if CommandLine.arguments.contains("enable-testing") {
                self.deleteAll()
                UIView.setAnimationsEnabled(false)
            }
            #endif
        }
    }

    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext

        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }

        return dataController
    }()

    static let model: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "DiceSim", withExtension: "momd") else {
            fatalError("Failed to locate model file.")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load model file.")
        }

        return managedObjectModel
    }()

    func createSampleData() throws {
        let viewContext = container.viewContext

        let game = Game(context: viewContext)
        game.title = "Monopoly"
        game.datePlayed = Date()

        let names = ["Antonio", "Braulio", "Eduardo", "Yajaira"]

        for i in 0..<4 {
            let player = Player(context: viewContext)
            player.name = names[i]
            player.color = Player.colors[i]
            player.game = game

            for _ in 1...8 {
                let roll = Roll(context: viewContext)
                roll.id = UUID()
                roll.die1 = Int16.random(in: 1...6)
                roll.die2 = Int16.random(in: 1...6)
                roll.date = Date()
                roll.player = player
            }
        }

        for _ in 0..<8 {
            let roll = Roll(context: viewContext)
            roll.id = UUID()
            roll.die1 = Int16.random(in: 1...6)
            roll.die2 = Int16.random(in: 1...6)
            roll.date = Date()
        }

        try viewContext.save()
    }

    func addPlayer(to game: Game) {
        let viewContext = container.viewContext

        let index = game.gamePlayers.count
        let player = Player(context: viewContext)
        player.name = "Player \(index + 1)"
        player.color = Player.colors[index]
        player.game = game

        save()
    }

    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }

    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }

    private func batchDelete(_ entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs

        let batchDelete = try? container.viewContext.execute(deleteRequest) as? NSBatchDeleteResult

        guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return }

        let deletedObjects: [AnyHashable: Any] = [NSDeletedObjectsKey: deleteResult]

        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: deletedObjects, into: [container.viewContext])
    }

    func deleteAll() {
        let entities = ["Roll", "Player", "Game"]

        for entity in entities {
            batchDelete(entity)
        }
    }
}
