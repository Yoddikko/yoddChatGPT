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
