//
//  File.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import SwiftUI

/**
 This is the ViewModel that manages the accent color in all the app.

 - Version: 0.1

 */
class AccentColor : ObservableObject {
    
    static let shared = AccentColor()
    
    
    var accentColorUserDefaults : String = UserDefaults.standard.string(forKey: "AccentColor") ?? ""

    
    @Published var accentColor : Color
    
    init () {
        if self.accentColorUserDefaults.isEmpty {
            self.accentColor = .blue
        } else {
            self.accentColor = Color(hex: accentColorUserDefaults)
        }
    }
    
    
    func getAccentColor () -> Color {
        return accentColor
    }
}
