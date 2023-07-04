//
//  OnboardingView.swift
//  Restart
//
//  Created by Lucas de Castro Souza on 02/07/23.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var onboardingViewed: Bool = false
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGFloat = 0
    @State private var sectionIndex: Int = 1
    private var actualTheme: Theme {
        themes[sectionIndex]
    }
    

    var body: some View {
        ZStack {
            Color(actualTheme.mainColor)
                .ignoresSafeArea()
                .animation(.linear(duration: 0.25), value: sectionIndex)
            VStack(spacing: 20) {
                // MARK: - Header

                Spacer()
                VStack(spacing: 0) {
                    Text(actualTheme.title)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)

                    Text(actualTheme.description)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeInOut(duration: 1), value: isAnimating)
                
                // MARK: - Center

                CharacterGroupView(
                    leftCharacter: "character-4",
                    middleCharacter: "character-1",
                    rightCharacter: "character-3",
                    sectionIndex: $sectionIndex
                )
                
                // MARK: - Footer
                
                ZStack {
                    //: Background
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    //: Button Background
                    HStack {
                        Capsule()
                            .fill(Color(actualTheme.secondaryColor))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    
                    //: Button
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color(actualTheme.secondaryColor))
                                .animation(.linear(duration: 0.25), value: sectionIndex)
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .offset(x: buttonOffset)
                        .frame(width: 80, height: 80, alignment: .center)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            buttonOffset = buttonWidth - 80
                                            playSound(sound: "chimeup", type: .mp3)
                                            onboardingViewed = true
                                        } else {
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: 80)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 45)
                .animation(.easeInOut(duration: 1), value: isAnimating)
                
                Spacer()
            }
        }
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

// MARK: - Preview

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
