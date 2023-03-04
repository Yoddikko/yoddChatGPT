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
import StoreKit

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
    @State var showAPIModal = false
    ///This is the variable that shows the alert for deleting the messages
    @State var peresentDeleteMessagesAlert = false
    ///This is the variable that shows the alert for changing API
    @State private var presentAPIAlert = false
    // whether or not to show the Safari ViewController
    @State var showOpenAI = false
    @State var showGitHub = false
    @State var showFAQ = false
    
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
                
                if #available(iOS 16.0, *) {
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
                            Text("Paste your token here")
                        
                    })
                    
                    .onDisappear{
                        presentAPIAlert = false
                    }
                    .onChange(of: openAIViewModelToken) { token in
                        AIChatViewModel.shared.setAPItoken(string: token)
                    }
                    
                } else {
                    Button(action: {
                        self.showAPIModal = true
                    }) {
                        Text("Change API token")
                    }
                }
                
                Button(action: {
                    self.showOpenAI = true
                }) {
                    Text("Get API token")
                }
                
            })
            Section("Other", content: {
                
                Button(action: {
                    self.showGitHub = true
                }) {
                    Text("GitHub")
                }
                
                Button(action: {
                    self.showFAQ = true
                }) {
                    Text("FAQ")
                }
                
                Button(action: {
                    rateApp()
                }) {
                    Text("Rate the app")
                }
                
            })
        }
        .sheet(isPresented: $showAPIModal) {
            VStack {
                Text("Paste your token here")
                TextField("Token", text: $openAIViewModelToken)
                    .border(.gray)
                Button {
                    showAPIModal = false    
                } label: {
                    Text("Done")
                }
                
            }.padding()
                .onDisappear{
                    showAPIModal = false
                }
                .onChange(of: openAIViewModelToken) { token in
                    AIChatViewModel.shared.setAPItoken(string: token)
                }
            
        }

        .sheet(isPresented: $showOpenAI) {
            SafariView(url: URL(string: "https://beta.openai.com/account/api-keys")!)
        }
        .sheet(isPresented: $showGitHub) {
            SafariView(url: URL(string: "https://github.com/Yoddikko/yoddChatGPT")!)
        }
        .sheet(isPresented: $showFAQ) {
            SafariView(url: URL(string: "https://github.com/Yoddikko/yoddChatGPT/wiki/FAQ")!)
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

@ViewBuilder
func sectionAPI () -> some View {
    
}

func rateApp() {
    if #available(iOS 10.3, *) {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    } else if let url = URL(string: "https://apps.apple.com/us/app/yoddaichat/id1672839275") {
        UIApplication.shared.openURL(url)
    }
}
