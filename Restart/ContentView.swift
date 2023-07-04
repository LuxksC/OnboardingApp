//
//  ContentView.swift
//  Restart
//
//  Created by Lucas de Castro Souza on 02/07/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var onboardingViewed: Bool = false
    
    var body: some View {
        ZStack {
            if onboardingViewed {
                HomeView()
            } else {
                OnboardingView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
