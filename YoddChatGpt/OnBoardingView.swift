//
//  OnBoardingView.swift
//  YoddChatGpt
//
//  Created by Ale on 30/01/23.
//

import SwiftUI

struct OnBoardingView: View {
    @Binding var shouldShowOnBoarding : Bool
    @State var token : String = ""
    @FocusState var textIsFocused : Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 40) {
                    //                Spacer()
                    HStack {
                        Text("Yodd's ChatGPT")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.blue)
                            .padding(.trailing)
                        
                        Text("This is an open source app based on OpenAISwift library")
                            .font(.title3)
                            .fontWeight(.light)
                        Spacer()
                        
                    }
                    Divider()
                    HStack  {
                        Image(systemName: "questionmark")
                            .foregroundColor(.blue)
                            .padding(.trailing)
                        
                        Text("Ask OpenAI's ChatGPT a quick question (cannot remember past messages)")
                            .font(.title3)
                            .fontWeight(.light)
                        Spacer()
                        
                    }
                    Divider()
                    HStack  {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                            .padding(.trailing)
                        Text("Create or participate in a multipeer lobby to talk at ChatGPT with other people (WIP)")
                            .font(.title3)
                            .fontWeight(.light)
                        Spacer()
                        
                    }
                    Divider()
                }.padding(.top, 50)
                    .padding(.horizontal, 20)
                
                
                
                Text("Get your API token and paste it to use the app")
                    .padding(.top)
                Link("Get API token", destination: URL(string: "https://beta.openai.com/account/api-keys")!)
                    .padding(.top, 5)
                
                HStack {
                    TextField("Token", text: $token)
                        .focused($textIsFocused)
                        .textFieldStyle(.roundedBorder)
                    
                    
                    Button(action: {
                        UserDefaults.standard.set("false", forKey: "OnBoarding")
                        OpenAIViewModel.shared.setToken(string: token)
                        shouldShowOnBoarding = false
                        OpenAIViewModel.shared.setup()
                        
                    }, label: {
                        Text("Continue")
                    }).disabled(token.isEmpty ? true : false)
                    
                    
                }                        .padding(.horizontal, 30)                    .padding()
                
                
                
                    .navigationBarBackButtonHidden(true)
                
                
                
                
                Spacer()
                
            }
            .scrollDismissesKeyboard(.immediately)

            .onTapGesture {
                textIsFocused = false
            }

            
        }.navigationBarBackButtonHidden(true)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(shouldShowOnBoarding: .constant(true))
    }
}
