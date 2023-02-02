/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


//
//  ExampleThemeChat.swift
//  YoddChatGpt
//
//  Created by Ale on 29/01/23.
//

import SwiftUI

struct ExampleThemeChat: View {
    
    // MARK: - ViewModels
    var themeViewModel : ThemeViewModel = ThemeViewModel()

    // MARK: - Environmental objects
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Properties
    var primaryColor : Color
    var secondaryColor : Color
    var theme : Theme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .lightGray : .black).opacity(0.4)
            VStack {
                
                HStack {
                    Spacer()
                    Text("                       ")
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 30)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .padding(.trailing, 5)
                        .background {
                            LinearGradient(gradient: Gradient(colors: [primaryColor, secondaryColor]), startPoint: .topLeading, endPoint: .bottomTrailing).clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding(.leading, 30).padding(.trailing, 5)
                        }
                }
                HStack {
                    Text("              ")
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 30)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .padding(.leading, 5)
                        .background {
                            LinearGradient(gradient: Gradient(colors: [secondaryColor, primaryColor]), startPoint: .topLeading, endPoint: .bottomTrailing).clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding(.trailing, 30).padding(.leading, 5)
                        }
                    Spacer()
                }
                Text(themeViewModel.getStringFromTheme(theme: theme)).minimumScaleFactor(0.4)
            }
        }
    }
}


struct ExampleThemeChat_Previews: PreviewProvider {
    static var previews: some View {
        ExampleThemeChat(primaryColor: .blue, secondaryColor: .teal, theme: .mint)
    }
}
