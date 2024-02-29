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
    private var dragAreaThreshold: CGFloat = 65.0
    @State private var lastCardIndex: Int = 1
    @State private var cardRemovalTransition = AnyTransition.trailingBottom
    
    // MARK: - CARD VIEWS
    @State var cardViews: [CardView] = {
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
    
    private func moveCards() {
        cardViews.removeFirst()
        
        lastCardIndex += 1
        
        let honeymoon = honeymoonData[lastCardIndex % honeymoonData.count]
        
        let newCardView = CardView(honeymoon: honeymoon)
        
        cardViews.append(newCardView)
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
                        .overlay(content: {
                            ZStack {
                                // SYMBOL
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(
                                        dragState.translation.width < -dragAreaThreshold && isTopCard(cardView: cardView) ? 1 : 0
                                    )
                                
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(
                                        dragState.translation.width > dragAreaThreshold && isTopCard(cardView: cardView) ? 1 : 0
                                    )
                            }
                        })
                        .offset(x: isTopCard(cardView: cardView) ? dragState.translation.width : 0,
                                y: isTopCard(cardView: cardView) ? dragState.translation.height : 0)
                        .scaleEffect(isTopCard(cardView: cardView) && dragState.isDragging ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: isTopCard(cardView: cardView) ? Double(dragState.translation.width / 12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120), value: dragState.isDragging)
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
                                .onChanged({ value in
                                    guard case .second(true, let drag?) = value else { return }
                                    
                                    switch drag.translation.width {
                                    case _ where drag.translation.width < -dragAreaThreshold:
                                        cardRemovalTransition = .leadingBottom
                                    case _ where drag.translation.width > dragAreaThreshold:
                                        cardRemovalTransition = .trailingBottom
                                    default:
                                        break
                                    }
                                })
                                .onEnded({ value in
                                    guard case .second(true, let drag?) = value else { return }
                                    
                                    if drag.translation.width < -dragAreaThreshold || drag.translation.width > dragAreaThreshold {
                                        playSound(sound: "sound-rise", type: "mp3")
                                        moveCards()
                                    }
                                })
                        )
                    // TODO: Transition dont work in iOS 16.x/17
                        .transition(cardRemovalTransition)
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
