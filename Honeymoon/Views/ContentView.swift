//
//  ContentView.swift
//  Honeymoon
//
//  Created by Ivan Romero on 27/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CardView(honeymoon: honeymoonData[1])
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
