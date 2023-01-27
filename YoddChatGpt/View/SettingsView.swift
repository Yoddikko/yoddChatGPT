//
//  SettingsView.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var accentColor  = AccentColor.shared
    
    var body: some View {
        NavigationView {
            Form {
                Section("Chat", content: {
                    // TODO: - Saved messages view
                    HStack {
                        Text("Saved messages")
                        Spacer()
                        Image(systemName: "bookmark")
                    }
                    
                    HStack {
                        ColorPicker("Change accent color", selection: $accentColor.accentColor)
                    }
                    .onChange(of: accentColor.accentColor) { _ in
//                        UserDefaults.standard.set(Color.init(hex: "FFF"), forKey: "AccentColor")
                        UserDefaults.standard.set(accentColor.accentColor.toHex(), forKey: "AccentColor")

                    }
                    Button(action: {
                        
                    }, label: {
                        //TODO: - Prompt to ask to the user if he's sure
                        HStack {
                            Text("Delete all chats")
                            Spacer()
                            Image(systemName: "trash")
                        }.foregroundColor(.red)
                    })
                })
                
            }
            .navigationTitle("Settings")
        }.navigationBarTitleDisplayMode(.automatic)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
