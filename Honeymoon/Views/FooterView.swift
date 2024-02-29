//
//  FooterView.swift
//  Honeymoon
//
//  Created by Ivan Romero on 27/02/2024.
//

import SwiftUI

struct FooterView: View {
    // MARK: - PROPERTIES
    @Binding var showBookingAlert: Bool
    let haptics = UINotificationFeedbackGenerator()
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 42, weight: .light))
            
            Spacer()
            
            Button(action: {
                playSound(sound: "sound-click", type: "mp3")
                haptics.notificationOccurred(.success)
                showBookingAlert.toggle()
            }, label: {
                Text("Book Destination".uppercased())
                    .font(.system(.subheadline, design: .rounded, weight: .heavy))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .tint(.pink)
                    .background(
                        Capsule()
                            .stroke(.pink, lineWidth: 2)
                    )
            })
            
            Spacer()
            
            Image(systemName: "heart.circle")
                .font(.system(size: 42, weight: .light))
        }
        .padding()
    }
}


// MARK: - PREVIEW
#Preview(traits: .fixedLayout(width: 375, height: 80)) {
    FooterView(showBookingAlert: .constant(true))
}
