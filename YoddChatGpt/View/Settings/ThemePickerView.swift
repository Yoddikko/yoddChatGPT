//
//  ThemePickerView.swift
//  YoddChatGpt
//
//  Created by Ale on 29/01/23.
//

import SwiftUI

struct ThemePickerView: View {
    
    // MARK: - ViewModels and properties
    var themeViewModel = ThemeViewModel.shared
    var themes = ThemeViewModel.shared.themes
    @State var tappedTheme : Theme = ThemeViewModel.shared.theme
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                
                ForEach (themes, id: \.self) { theme in
                    ExampleThemeChat(primaryColor:  themeViewModel.getColorsFromThemeEnum(theme: theme).0, secondaryColor: themeViewModel.getColorsFromThemeEnum(theme: theme).1, theme: theme)
                        .frame(width: 100, height: 150).clipShape(RoundedRectangle(cornerRadius: 15))
                        .background {
                            if tappedTheme == theme {
                                RoundedRectangle(cornerRadius: 15).foregroundColor(.gray).padding(2)
                            }
                        }
                        .onTapGesture {
                            themeViewModel.setTheme(theme: theme)
                            self.tappedTheme = theme
                        }
                    
                }
            }
        }
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView()
    }
}
