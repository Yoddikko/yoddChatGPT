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
class ThemeViewModel : ObservableObject {
    
    static let shared = ThemeViewModel()
    
    var themes : [Theme] = [.native, .custom, .ice, .passion, .sun, .sky, .mint]
    
    var accentColorUserDefaults : String = UserDefaults.standard.string(forKey: "AccentColor") ?? ""
    
    var themeColorUserDefaults : String = UserDefaults.standard.string(forKey: "ThemeColor") ?? ""
    
    
    @Published var accentColor : Color
    
    @Published var theme : Theme
    
    init () {
        if self.accentColorUserDefaults.isEmpty {
            self.accentColor = .blue
        } else {
            self.accentColor = Color(hex: accentColorUserDefaults)
        }

        if self.themeColorUserDefaults.isEmpty {
            self.theme = .native
        } else {
            self.theme = .native
            self.theme = getThemefromString(stringTheme: themeColorUserDefaults)
            print (self.theme)
        }
    }
    
    func setTheme(theme : Theme) {
        UserDefaults.standard.set("\(theme)", forKey: "ThemeColor")
        self.theme = theme
    }
    
    
    func getAccentColor () -> Color {
        return accentColor
    }
    
    func getColorsFromThemeEnum(theme: Theme) -> (Color, Color) {
        switch theme {
        case .native:
            return (.primary.opacity(0.2), .secondary.opacity(0.2))
        case .custom:
            return  (.accentColor, .accentColor)
        case .ice:
            return (.blue, .teal.opacity(0.6))
        case .passion:
            return (.pink, .red.opacity(0.6))
        case .sun:
            return (.orange, .orange.opacity(0.6))
        case .sky:
            return (.blue.opacity(0.3), .teal.opacity(0.3))
        case .mint:
            return (.green, .mint.opacity(0.6))
        }
    }
    func getThemefromString(stringTheme: String) -> Theme {
        switch stringTheme {
        case "native":
            return .native
        case "custom":
            return  .custom
        case "ice":
            return .ice
        case "passion":
            return .passion
        case "sun":
            return .sun
        case "sky":
            return .sky
        case "mint":
            return .mint
        default:
            return .native
        }
    }
    func getStringFromTheme(theme: Theme) -> String {
        switch theme {
        case .native:
            return "🤖 Native"
        case .custom:
            return  "✏️ Custom"
        case .ice:
            return "🧊 Ice"
        case .passion:
            return "🔥 Passion"
        case .sun:
            return "☀️ Sun"
        case .sky:
            return "☁️ Sky"
        case .mint:
            return "🌿 Mint"
        default:
            return "🤖 Native"
        }

    }
}

enum Theme {
    case native, custom, ice, passion, sun, sky, mint
}
