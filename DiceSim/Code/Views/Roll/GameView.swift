//
//  GameView.swift
//  DiceSim
//
//  Created by Antonio Vega on 9/1/21.
//

import SwiftUI
import CoreData

struct GameView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    
    @State private var die1 = 2
    @State private var die2 = 4
    @State private var rolling = false
    @State private var selected = 0

    let gameRequest: FetchRequest<Game>

    var game: Game {
        gameRequest.wrappedValue.first ?? Game()
    }

    init() {
        let request: NSFetchRequest<Game> = Game.fetchRequest()

        request.predicate = nil
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Game.datePlayed, ascending: false)]
        request.fetchLimit = 1

        self.gameRequest = FetchRequest(fetchRequest: request)
    }

    var body: some View {
        VStack {
            HStack {
                ForEach(game.gamePlayers.indices) { index in
                    Text(game.gamePlayers[index].playerName)
                        .font(.headline)
                        .padding([.horizontal], 10)
                        .padding([.vertical], 5)
                        .foregroundColor(index == selected ? .white : .primary)
                        .background(index == selected ? Color(game.gamePlayers[index].playerColor) : Color.clear)
                        .clipShape(Capsule())
                        .padding(3)
                        .animation(.spring(response: 1.0, dampingFraction: 1.5, blendDuration: 1.0))
                }
            }
            .offset(y: 25.0)

            Spacer()

            HStack {
                Image(systemName: "die.face.\(die1).fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .animation(.linear)

                Image(systemName: "die.face.\(die2).fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .animation(.linear)
            }

            Spacer()

            Button {
                rollDice()
            } label: {
                Text("Roll")
            }
            .buttonStyle(AppleButtonStyle(color: .blue))
            .opacity(rolling ? 0.5 : 1.0)
            .allowsHitTesting(!rolling)
            .padding()
        }
    }

    func rollDice() {
        rolling = true

        for i in stride(from: 0.0, to: 1.2, by: 0.1) {
            let gap = i * i * 2
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(gap)) {
                die1 = Int.random(in: 1...6)
                die2 = Int.random(in: 1...6)

                if i >= 1.1 {
                    withAnimation {
                        rolling = false
                        createAndSaveRollEntity()

                        selected = selected + 1 < game.gamePlayers.count ? selected + 1: 0
                    }
                }
            }
        }
    }

    func createAndSaveRollEntity() {
        let roll = Roll(context: managedObjectContext)
        roll.id = UUID()
        roll.die1 = Int16(die1)
        roll.die2 = Int16(die2)
        roll.date = Date()
        roll.player = game.gamePlayers[selected]
        dataController.save()
    }
}

struct GameView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        GameView()
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
