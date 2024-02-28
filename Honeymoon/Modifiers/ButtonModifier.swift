//
//  ButtonModifier.swift
//  Honeymoon
//
//  Created by Ivan Romero on 27/02/2024.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(.pink)
            )
            .foregroundStyle(.white)
    }
}
