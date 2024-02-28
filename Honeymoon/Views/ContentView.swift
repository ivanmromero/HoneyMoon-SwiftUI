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
    @State private var showInfo: Bool = false
    @GestureState private var dragState = DragState.inactive
    
    // MARK: - CARD VIEWS
    var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(CardView(honeymoon: honeymoonData[index]))
        }
        
        return views
    }()
    
    // MARK: - FUNCTIONS
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else { return false }
        
        return index == 0
    }
    
    // MARK: - ENUM DRAG STATES
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .inactive:
                return false
            case .pressing, .dragging:
                return true
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // MARK: - HEADER
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                .opacity(dragState.isDragging ? 0 : 1)
                .animation(.default, value: UUID())
            
            Spacer()
            
            // MARK: - CARDS
            ZStack{
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                        .offset(x: isTopCard(cardView: cardView) ? dragState.translation.width : 0,
                                y: isTopCard(cardView: cardView) ? dragState.translation.height : 0)
                        .scaleEffect(isTopCard(cardView: cardView) && dragState.isDragging ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: isTopCard(cardView: cardView) ? Double(dragState.translation.width / 12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120), value: UUID())
                        .gesture(
                            LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating($dragState, body: { value, state, transaction in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }
                                })
                        )
                }
            }
            .padding()
            
            Spacer()
            
            // MARK: - FOOTER
            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? 0 : 1)
                .animation(.default, value: UUID())
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
