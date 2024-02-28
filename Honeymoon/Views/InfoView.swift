//
//  InfoView.swift
//  Honeymoon
//
//  Created by Ivan Romero on 27/02/2024.
//

import SwiftUI

struct InfoView: View {
    // MARK: - PROPERTIES
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                
                Spacer(minLength: 10)
                
                Text("App Info")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                AppInfoView()
                
                Text("Credits")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                CreditsView()
                
                Spacer(minLength: 10)
                
                Button(action: {
                   
                }, label: {
                    Text("Continue".uppercased())
                        .modifier(ButtonModifier())
                })
            }
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
    InfoView()
}

struct AppInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RowAppInfoView(itemOne: "Application", itemTwo: "Honeymoon")
            RowAppInfoView(itemOne: "Compatibility", itemTwo: "iPhone and iPad")
            RowAppInfoView(itemOne: "Developer", itemTwo: "Ivan Manuel Romero")
            RowAppInfoView(itemOne: "Version", itemTwo: "1.0.0")
        }
    }
}

struct RowAppInfoView: View {
    // MARK: - PROPERTIES
    let itemOne: String
    let itemTwo: String
    
    var body: some View {
        VStack {
            HStack(content: {
                Text(itemOne)
                    .foregroundStyle(.gray)
                Spacer()
                Text(itemTwo)
            })
            Divider()
        }
    }
}

struct CreditsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(content: {
                Text("Photos")
                    .foregroundStyle(.gray)
                Spacer()
                Text("Unsplash")
            })
            
            Divider()
            
            Text("Photographers")
                .foregroundStyle(.gray)
            
            Text("Shifaaz Shamoon (Maldives), Grillot Edouard (France), Evan Wise (Greece), Christoph Schulz (United Arab Emirates), Andrew Coelho (USA), Damiano Baschiera (Italy), Daniel Olah (Hungary), Andrzej Rusinowski (Poland), Lucas Miguel (Slovenia), Florencia Potter (Spain), Ian Simmonds (USA), Ian Keefe (Canada), Denys Nevozhai (Thailand), David Köhler (Italy), Andre Benz (USA), Alexandre Chambon (South Korea), Roberto Nickson (Mexico), Ajit Paul Abraham (UK), Jeremy Bishop (USA), Davi Costa (Brazil), Liam Pozz (Australia)")
                .multilineTextAlignment(.leading)
                .font(.footnote)
        }
    }
}
