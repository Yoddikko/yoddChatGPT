/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
class ThemeViewModel: ObservableObject {
    
    static let shared = ThemeViewModel()
    
    var themes: [Theme] = [.native, .custom, .ice, .passion, .sun, .sky, .mint]
    
    var accentColorUserDefaults: String = UserDefaults.standard.string(forKey: "AccentColor") ?? ""
    
    var themeColorUserDefaults: String = UserDefaults.standard.string(forKey: "ThemeColor") ?? ""
    
    @Published var accentColor: Color
    
    @Published var theme: Theme
    
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
        }
    }
    
    func setTheme(theme: Theme) {
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
            return (.blue.opacity(0.5), .teal.opacity(0.7))
        case .passion:
            return (.pink.opacity(0.5), .red.opacity(0.6))
        case .sun:
            return (.orange, .orange.opacity(0.6))
        case .sky:
            return (.blue.opacity(0.3), .teal.opacity(0.3))
        case .mint:
            return (.green.opacity(0.5), .mint.opacity(0.5))
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
        }

    }
}

enum Theme {
    case native, custom, ice, passion, sun, sky, mint
}
