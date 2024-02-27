//
//  CardView.swift
//  Honeymoon
//
//  Created by Ivan Romero on 27/02/2024.
//

import SwiftUI

struct CardView: View {
    // MARK: - PROPERTIES
    let id = UUID()
    let honeymoon: Destination
    
    // MARK: - BODY
    var body: some View {
        Image(honeymoon.image)
            .resizable()
            .clipShape(.rect(cornerRadius: 24))
            .scaledToFit()
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay(alignment: .bottom) {
                VStack(alignment: .center, spacing: 12, content: {
                    Text(honeymoon.place.uppercased())
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 1)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 4)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .fill(.white)
                                .frame(height: 1)
                        }
                    Text(honeymoon.country.uppercased())
                        .foregroundStyle(.black)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(minWidth: 85)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(.white)
                        )
                })
                .frame(minWidth: 280)
                .padding(.bottom, 50)
            }
    }
}

// MARK: - PREVIEW
#Preview(traits: .fixedLayout(width: 375, height: 600)) {
    CardView(honeymoon: honeymoonData[1])
        .padding()
}
