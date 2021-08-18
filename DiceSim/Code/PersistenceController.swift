//
//  PersistenceController.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import CoreData

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

//         Create 10 example programming languages.
        for _ in 0..<10 {
            let roll = Roll(context: controller.container.viewContext)
            roll.id = UUID()
            roll.die1 = Int16.random(in: 1...6)
            roll.die2 = Int16.random(in: 1...6)
            roll.date = Date()
            try! controller.container.viewContext.save()
        }
        
        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "DiceSim")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("FAILED SAVE - \(error.localizedDescription)")
            }
        }
    }
}
