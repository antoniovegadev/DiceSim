//
//  Button.swift
//  DiceSim
//
//  Created by Antonio Vega on 9/5/21.
//

import SwiftUI

struct AppleButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .padding(.vertical)
            .padding(.horizontal, 50)
            .frame(width: 250)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .overlay(
                Color.black
                    .opacity(configuration.isPressed ? 0.3 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
}
