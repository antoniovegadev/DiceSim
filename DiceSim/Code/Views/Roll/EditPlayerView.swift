//
//  EditPlayerView.swift
//  DiceSim
//
//  Created by Antonio Vega on 9/1/21.
//

import SwiftUI

struct EditPlayerView: View {
    @ObservedObject var player: Player
    let playerCount: Int

    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String
    @State private var color: String
    @State private var showingDeletePlayerAlert = false

    let colorColumns = [
        GridItem(.adaptive(minimum: 44))
    ]

    init(player: Player, playerCount: Int) {
        self.player = player
        self.playerCount = playerCount

        _name = State(wrappedValue: player.playerName)
        _color = State(wrappedValue: player.playerColor)
    }

    var body: some View {
        Form {
            Section(header: Text("Player name")) {
                TextField("Name", text: $name.onChange(update))
            }

            Section(header: Text("Player color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Player.colors, id: \.self, content: colorButton)
                }
                .padding(.vertical)
            }

            if playerCount > 2 {
                Section {
                    Button("Delete Player") {
                        showingDeletePlayerAlert = true
                    }
                    .accentColor(.red)
                }
            }
        }
        .navigationTitle("Edit Player")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeletePlayerAlert) {
            Alert(
                title: Text("Delete Player?"),
                message: Text("Are you sure you want to delete this player?"),
                primaryButton: .destructive(Text("Delete"), action: delete),
                secondaryButton: .cancel()
            )
        }
    }

    func colorButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(6)

            if item == color {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            color = item
            update()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(
            item == color
                ? [.isButton, .isSelected]
                : .isButton
        )
        .accessibilityLabel(LocalizedStringKey(item))
    }

    func update() {
        player.game?.objectWillChange.send()
        
        player.name = name
        player.color = color
    }

    func delete() {
        dataController.delete(player)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditPlayerView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        EditPlayerView(player: Player.example, playerCount: 3)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
