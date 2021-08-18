//
//  DiceSimApp.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI

@main
struct DiceSimApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
