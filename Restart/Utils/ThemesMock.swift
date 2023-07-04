//
//  ThemesMock.swift
//  Restart
//
//  Created by Lucas de Castro Souza on 04/07/23.
//

import Foundation

struct Theme {
    let id: String
    let mainColor: String
    let secondaryColor: String
    let title: String
    let description: String
    
    init(mainColor: String, secondaryColor: String, title: String, description: String) {
        self.id = UUID().uuidString
        self.mainColor = mainColor
        self.secondaryColor = secondaryColor
        self.title = title
        self.description = description
    }
}

let themes = [
    Theme(
        mainColor: "ColorYellow",
        secondaryColor: "ColorBlue",
        title: "Speak.",
        description: "To shine your brightest light\nis to be who you truly are."
    ),
    Theme(
        mainColor: "ColorBlue",
        secondaryColor: "ColorRed",
        title: "Share.",
        description: "It's not how much we give but\nhow much love we put into giving."
    ),
    Theme(
        mainColor: "ColorRed",
        secondaryColor: "ColorYellow",
        title: "Grow.",
        description: "If everyone is moving forward together,\nthen success takes care of itself."
    )
]
