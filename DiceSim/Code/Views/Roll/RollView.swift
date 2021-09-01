//
//  RollView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI
import CoreHaptics

struct RollView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var die1 = 2
    @State private var die2 = 4
    @State private var rolling = false
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack {
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
            
            Button(action: rollDice) {
                Text("Roll")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 150, height: 60)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            .offset(y: -20)
            .opacity(rolling ? 0.5 : 1.0)
            .allowsHitTesting(!rolling)
        }
        .onAppear(perform: prepareHaptics)
    }
}

// MARK: - Functions
extension RollView {
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        for i in 0...1 {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: Double(i) * 0.25)
            events.append(event)
        }

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
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
                    rolling = false
                    complexSuccess()
                    createAndSaveRollEntity()
                }
            }
        }
    }
    
    func createAndSaveRollEntity() {
        let roll = Roll(context: moc)
        roll.id = UUID()
        roll.die1 = Int16(die1)
        roll.die2 = Int16(die2)
        roll.date = Date()
        try? moc.save()
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
