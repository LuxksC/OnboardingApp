//
//  HomeView.swift
//  Restart
//
//  Created by Lucas de Castro Souza on 02/07/23.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var onboardingViewed: Bool = true

    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            // MARK: - Header
            
            Spacer()
            
            ZStack{
                CircleGroupView(shapeColor: Color("ColorGray"), shapeOpacity: 0.2)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        Animation
                            .easeInOut(duration: 3)
                            .repeatForever()
                        , value: isAnimating)
            }
            
            // MARK: - Center
            
            Text("The time that leads to mastery is dependent on the intensity of your focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(Color("ColorGray"))
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            // MARK: - Footer
            
            Button(action: {
                withAnimation {
                    onboardingViewed = false
                    playSound(sound: "success", type: .m4a)
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
            Spacer()
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        })
    }
}

// MARK: - Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
