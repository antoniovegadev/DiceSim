//
//  HistoryListView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI

enum HistoryMode: String, CaseIterable {
    case solo = "Solo"
    case game = "Game"
}

struct HistoryListView: View {
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(
        entity: Roll.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Roll.date, ascending: false)],
        predicate: NSPredicate(format: "player = nil")
    ) var rolls: FetchedResults<Roll>

    @FetchRequest(
        entity: Game.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Game.datePlayed, ascending: false)]
    ) var games: FetchedResults<Game>

    @State private var historyMode: HistoryMode = .solo
    @State private var showingDeleteConfirmationAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Choose a history view", selection: $historyMode) {
                    ForEach(HistoryMode.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if historyMode == .solo {
                    List {
                        ForEach(rolls) { roll in
                            HistoryRowView(roll: roll)
                        }
                    }
                    .listStyle(InsetListStyle())
                } else if historyMode == .game {
                    List {
                        ForEach(games) { game in
                            NavigationLink(destination: GameDetailView(game: game)) {
                                GameRowView(game: game)
                            }
                        }
                    }
                    .listStyle(InsetListStyle())
                }
            }
            .navigationTitle("History")
            .toolbar {
                ToolbarItem {
                    Button {
                        showingDeleteConfirmationAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .accentColor(.red)
        .alert(isPresented: $showingDeleteConfirmationAlert) {
            Alert(
                title: Text("Delete History?"),
                message: Text("Are you sure you want to delete the current history?"),
                primaryButton: .destructive(Text("Delete"), action: dataController.deleteAll),
                secondaryButton: .cancel()
            )
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        HistoryListView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
