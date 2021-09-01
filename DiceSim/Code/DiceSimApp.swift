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
    @StateObject var dataController: DataController

    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
        .onChange(of: scenePhase) { _ in
            dataController.save()
        }
    }
}
