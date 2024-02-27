//
//  HeaderView.swift
//  Honeymoon
//
//  Created by Ivan Romero on 27/02/2024.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Button(action: {
                
            }, label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            })
            .tint(.primary)
            
            Spacer()
            
            Image(.logoHoneymoonPink)
                .resizable()
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular))
            })
            .tint(.primary)
        }
        .padding()
    }
}

// MARK: - PREVIEW
#Preview(traits: .fixedLayout(width: 375, height: 80)) {
    HeaderView()
}
