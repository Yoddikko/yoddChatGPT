/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  OnBoarding2.swift
//  YoddChatGpt
//
//  Created by Ale on 01/02/23.
//

import SwiftUI

/**
 This is the view that contains the second screen of the onboarding.
 
 - Version: 0.2
 
 */

struct OnBoarding2: View {
    
    @State var token = ""
    @FocusState var textFocused: Bool
    @AppStorage ("shouldShowOnBoarding") var shouldShowOnBoarding: Bool = true
    // whether or not to show the Safari ViewController
    @State var showSafari = false
    // initial URL string
    @State var urlString = "https://beta.openai.com/account/api-keys"

    var body: some View {
        VStack {
            Text("Get the API token")
                .font(.title)
                .fontWeight(.bold)
                        
            Text("To use the app, you must generate a token to access the OpenAI API.")
                .fontWeight(.light)
                .padding(.horizontal)
                .padding(.top, 1)
            
            Text("This app was not made by OpeanAI. This is an independent and completely free project that connects to OpenAI's public API. The app is not affiliated with OpenAI in any way, and if OpenAI would like to request closure of the project they could contact me.")
                .fontWeight(.heavy)
                .foregroundColor(.red)
                .padding()
            
            Text("NOTE: Apparenlty you need to have some credits on your OpenAI account, if you don't have them is looks that adding a payment method to your account is enough")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
            
            Button(action: {
                self.urlString = "https://beta.openai.com/account/api-keys"
                self.showSafari = true
            }) {
                Text("Get API token")
            }
                .padding(.horizontal)

            TextField("API Token", text: $token)
                .focused($textFocused)
                .padding()

                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.secondary, lineWidth: 2))
                .padding()
            
            Button(action: {
                UserDefaults.standard.set("false", forKey: "OnBoarding")
                AIChatViewModel.shared.setTokenOpenAISwift(string: token)
                shouldShowOnBoarding = false
                AIChatViewModel.shared.setup()
                textFocused = false
            }, label: {
                Text("Continue")
            }).buttonStyle(.bordered)
            Spacer()
        }.onTapGesture {
            textFocused = false
        }
        .sheet(isPresented: $showSafari) {
            SafariView(url: URL(string: self.urlString)!)
        }

    }
}

struct OnBoarding2_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding2()
    }
}
