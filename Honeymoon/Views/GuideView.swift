//
//  GuideView.swift
//  Honeymoon
//
//  Created by Ivan Romero on 27/02/2024.
//

import SwiftUI

struct GuideView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 20, content: {
                HeaderComponent()
                Spacer(minLength: 10)
                
                Text("Get Started!")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                Text("Discover and pick the perfect destination for your romantic Honeymoon!")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 10)
                
                VStack(alignment: .leading, spacing: 25, content: {
                    GuideComponent(title: "Like",
                                   subtitle: "Swipe right",
                                   description: "Do you like destination? Touch the screen and swipe right. It will be saved to the favourites.", icon: "heart.circle")
                    
                    GuideComponent(title: "Dismiss",
                                   subtitle: "Swipe Left",
                                   description: "Would you rather skip this place? Touch the screen and swipe left. You will no longer see it.", icon: "xmark.circle")
                    
                    GuideComponent(title: "Book",
                                   subtitle: "Tap the button",
                                   description: "Our selection of honeymoon resorts is perfect setting for you embark your new life together", icon: "checkmark.square")
                })
                
                Spacer(minLength: 10)
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Continue".uppercased())
                        .modifier(ButtonModifier())
                })
            })
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)

        }
        .scrollIndicators(.hidden)
    }
}

// MARK: - PREVIEW
#Preview {
    GuideView()
}
