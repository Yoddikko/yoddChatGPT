//
//  SettingsButton.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import SwiftUI

@ViewBuilder
func createSettingsButton () -> some View {
    HStack {
        Spacer()
        Button(action: {
            
        }) {
            Image(systemName: "gear")
                .resizable()
                .frame(width: 30, height: 30)
        }

    }
    .padding()
}
