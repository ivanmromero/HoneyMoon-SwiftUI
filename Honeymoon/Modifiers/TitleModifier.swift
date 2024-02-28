//
//  TitleModifier.swift
//  Honeymoon
//
//  Created by Ivan Romero on 27/02/2024.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.pink)
    }
}
