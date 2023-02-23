/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
    @State var tappedTheme: Theme = ThemeViewModel.shared.theme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                
                ForEach (themes, id: \.self) { theme in
                    ExampleThemeChat(primaryColor: themeViewModel.getColorsFromThemeEnum(theme: theme).0, secondaryColor: themeViewModel.getColorsFromThemeEnum(theme: theme).1, theme: theme)
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
