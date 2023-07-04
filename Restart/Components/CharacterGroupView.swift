//
//  CharacterGroupView.swift
//  Restart
//
//  Created by Lucas de Castro Souza on 03/07/23.
//

import SwiftUI

enum CharacterGroupSectcion {
    case left
    case middle
    case right
}

struct CharacterGroupView: View {
    var leftCharacter: String
    var middleCharacter: String
    var rightCharacter: String
    @Binding var sectionIndex: Int
    @State var imageOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var indicatorOpacity: Double = 1.0
    @State private var indicatorType: String = "arrow.left.and.right.circle"
    
    var body: some View {
        ZStack {
            // MARK: - Middle Circle
            
            CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                .blur(radius: abs(imageOffset / 10))
                .offset(x: imageOffset * -1.2)
                .animation(.easeOut(duration: 0.7), value: imageOffset)
            
            // MARK: - Right Circle
            
            CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                .blur(radius: abs((imageOffset + 350) / 10))
                .offset(x: (imageOffset + 350) * -1.2)
                .animation(.easeOut(duration: 0.7), value: imageOffset)
            
            // MARK: - Left Circle

            CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                .blur(radius: abs((imageOffset - 350) / 10))
                .offset(x: (imageOffset - 350) * -1.2)
                .animation(.easeOut(duration: 0.7), value: imageOffset)
            
            // MARK: - Middle Image
            
            Image(middleCharacter)
                .resizable()
                .scaledToFit()
                .opacity(isAnimating ? 1 : 0)
                .offset(x: imageOffset * 1.2)
                .rotationEffect(.degrees(Double(imageOffset / 20)))
                .animation(.easeInOut(duration: 0.5), value: isAnimating)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if abs(imageOffset) < 350 {
                                imageOffset = gesture.translation.width
                                hideIndicator()
                            }
                        }
                        .onEnded { _ in
                            showIndicator()
                            if imageOffset > 150 {
                                imageOffset = 350
                                indicatorType = "arrow.right.circle"
                                sectionIndex = 0
                            } else if imageOffset < -150 {
                                imageOffset = -350
                                indicatorType = "arrow.left.circle"
                                sectionIndex = 2
                            } else {
                                imageOffset = 0
                            }
                            
                        }
                )
                .animation(.easeOut(duration: 0.7), value: imageOffset)
            
            // MARK: - Right Image
            
            Image(rightCharacter)
                .resizable()
                .scaledToFit()
                .padding(-20)
                .rotationEffect(.degrees(Double((imageOffset + 350) / 20)))
                .offset(x: (imageOffset + 350) * 1.2)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            hideIndicator()
                            if imageOffset >= -350 {
                                imageOffset = gesture.translation.width - 350
                            }
                        }
                        .onEnded { _ in
                            showIndicator()
                            if imageOffset > -150 {
                                imageOffset = 0
                                indicatorType = "arrow.left.and.right.circle"
                                sectionIndex = 1
                            } else {
                                imageOffset = -350
                            }
                        }
                )
                .animation(.easeOut(duration: 0.7), value: imageOffset)
            
            // MARK: - Left Image

            Image(leftCharacter)
                .resizable()
                .scaledToFit()
                .padding(-20)
                .rotationEffect(.degrees(Double((imageOffset - 350) / 20)))
                .offset(x: (imageOffset - 350) * 1.2)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            hideIndicator()
                            if imageOffset <= 350 {
                                imageOffset = gesture.translation.width + 350
                            }
                        }
                        .onEnded { _ in
                            showIndicator()
                            if imageOffset < 150 {
                                imageOffset = 0
                                indicatorType = "arrow.left.and.right.circle"
                                sectionIndex = 1
                            } else {
                                imageOffset = 350
                            }
                        }
                )
                .animation(.easeOut(duration: 0.7), value: imageOffset)
        }
        .onAppear(perform: {
            isAnimating = true
        })
        .overlay(
            Image(systemName: indicatorType)
                .font(.system(size: 44, weight: .ultraLight))
                .foregroundColor(.white)
                .offset(y: 20)
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeOut(duration: 0.5).delay(1.5), value: isAnimating)
                .opacity(indicatorOpacity)
            , alignment: .bottom
        )
    }
    
    private func hideIndicator() {
        withAnimation(.linear(duration: 0.25)) {
            indicatorOpacity = 0
        }
    }
    
    private func showIndicator() {
        withAnimation(.linear(duration: 0.25)) {
            indicatorOpacity = 1
        }
    }
}

struct CharacterGroupView_Previews: PreviewProvider {
    static var previews: some View {
        @State var sectionIndex: Int = 1
        
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            CharacterGroupView(
                leftCharacter: "character-4",
                middleCharacter: "character-1",
                rightCharacter: "character-3",
                sectionIndex: $sectionIndex
            )
        }
    }
}
