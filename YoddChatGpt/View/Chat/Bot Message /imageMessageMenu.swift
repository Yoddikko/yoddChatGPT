//
//  imageMessageMenu.swift
//  YoddChatGpt
//
//  Created by Ale on 03/03/23.
//

import SwiftUI

@ViewBuilder
func imageMessageMenu (message: Message) -> some View {
    Button(action: {
        downloadImage(url: message.body!)
    }) {
        Label("Download", systemImage: "arrow.down.circle")
    }

}
