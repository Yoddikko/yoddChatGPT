//
//  OnBoarding2.swift
//  YoddChatGpt
//
//  Created by Ale on 01/02/23.
//

import SwiftUI

struct OnBoarding2: View {
    
    @State var token = ""
    @FocusState var textFocused : Bool
    @AppStorage ("shouldShowOnBoarding") var shouldShowOnBoarding : Bool = true

    var body: some View {
        VStack {
            Text("Get the API token")
                .font(.title)
                .fontWeight(.bold)
            
            
            Text("To use the app, you must generate a token to access the OpenAI API.")
                .fontWeight(.light)
                .padding(.horizontal)
                .padding(.top, 1)
            
            Link("Get API token", destination: URL(string: "https://beta.openai.com/account/api-keys")!)
                .padding(.top)

            TextField("API Token", text: $token)
                .focused($textFocused)
                .padding()

                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.secondary, lineWidth: 2))
                .padding()
            
            
            Button(action: {
                UserDefaults.standard.set("false", forKey: "OnBoarding")
                OpenAIViewModel.shared.setToken(string: token)
                shouldShowOnBoarding = false
                OpenAIViewModel.shared.setup()

            }, label: {
                Text("Continue")
            }).buttonStyle(.bordered)
            Spacer()
        }.onTapGesture {
            textFocused = false
        }
    }
}

struct OnBoarding2_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding2()
    }
}
