/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  SettingsView.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import SwiftUI
import OpenAISwift
/**
 This is the settings view with the list of all the settings in the app.
 
 - Version: 0.1
 
 */

struct SettingsView: View {
    // MARK: - Environmental objects
    @Environment (\.managedObjectContext) var managedObjectContext
    
    // MARK: - ViewModels
    @ObservedObject var themeViewModel = ThemeViewModel.shared
    @State var openAIViewModelToken = UserDefaults.standard.string(forKey: "token") ?? ""
    
    // MARK: - Other properties
    
    ///This is the variable that shows the alert for deleting the messages
    @State var peresentDeleteMessagesAlert = false
    ///This is the variable that shows the alert for changing API
    @State private var presentAPIAlert = false
    // whether or not to show the Safari ViewController
    @State var showSafari = false
    // initial URL string
    @State var urlString = "https://beta.openai.com/account/api-keys"

    var body: some View {
            Form {
                Section("Theme", content: {
                    HStack {
                        ColorPicker("Change accent color", selection: $themeViewModel.accentColor)
                    }
                    .onChange(of: themeViewModel.accentColor) { _ in
                        UserDefaults.standard.set(themeViewModel.accentColor.toHex(), forKey: "AccentColor")
                    }
                    
                    ThemePickerView()
                    
                })
                
                Section("Chat", content: {
                    
                    NavigationLink(destination: {
                        SavedMessagesView()
                    }, label: {
                        HStack {
                            Text("Saved messages")
                            Spacer()
                            Image(systemName: "bookmark.fill")
                        }
                    })
                    Toggle(isOn: AIChatViewModel.shared.$showModelType) {
                        Text("Show model type stamp")
                    }
                    
                    Button(action: {
                        peresentDeleteMessagesAlert = true
                    }, label: {
                        HStack {
                            Text("Delete all messages")
                            Spacer()
                            Image(systemName: "trash")
                        }.foregroundColor(.red)
                    })
                    .confirmationDialog("Are you sure?",
                                        isPresented: $peresentDeleteMessagesAlert) {
                        Button("Delete all messages?", role: .destructive) {
                            DataController.shared.deleteAllData(context: managedObjectContext)
                        }
                        Button("Delete all unsaved messages?", role: .destructive) {
                            DataController.shared.deleteAllUnsavedData(context: managedObjectContext)
                        }

                    } message: {
                        Text("You cannot undo this action")
                    }
                })
                Section("API", content: {
                    
                    NavigationLink(destination: {
                        AILibrariesList()
                    }, label: {
                        HStack {
                            Text("Change model type")
                            Spacer()
                            Image(systemName: "list.bullet")
                        }
                    })

                    Button(action: {
                        presentAPIAlert = true
                    }, label: {
                        HStack {
                            Text("Change API token")
                            Spacer()
                            Image(systemName: "key")
                        }
                    })
                    .alert("API Token", isPresented: $presentAPIAlert, actions: {
                        TextField("Token", text: $openAIViewModelToken)
                    }, message: {
                        HStack {
                            Text("Paste your token here")
                        }
                    })
                    .onDisappear{
                        presentAPIAlert = false
                    }
                    .onChange(of: openAIViewModelToken) { token in
                        AIChatViewModel.shared.setTokenOpenAISwift(string: token)
                    }
                    Button(action: {
                        self.urlString = "https://beta.openai.com/account/api-keys"
                        self.showSafari = true
                    }) {
                        Text("Get API token")
                    }

                })
            }
            .sheet(isPresented: $showSafari) {
                SafariView(url: URL(string: self.urlString)!)
            }
        
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
