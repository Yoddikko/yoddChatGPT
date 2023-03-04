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
        downloadImage(image: UIImage(data: message.data!) ?? UIImage())
    }) {
        Label("Download", systemImage: "arrow.down.circle")
    }

}

func downloadImage(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
}
