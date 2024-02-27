//
//  ContentView.swift
//  Honeymoon
//
//  Created by Ivan Romero on 27/02/2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var showAlert: Bool = false
    @State private var showGuide: Bool = false
    
    // MARK: - BODY
    var body: some View {
        VStack {
            HeaderView(showGuideView: $showGuide)
            
            Spacer()
            
            CardView(honeymoon: honeymoonData[1])
                .padding()
            
            Spacer()
            
            FooterView(showBookingAlert: $showAlert)
        }
        .alert("SUCCESS", isPresented: $showAlert) {
            Button("Happy Honeymoon!", action: {})
        } message: {
            Text("Wishing a lovely and most precious of the times together for the amazing couple.")
        }
    }
}

// MARK: - PREVIEW
#Preview {
    ContentView()
}
