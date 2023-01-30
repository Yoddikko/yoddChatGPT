//
//  EmptySavedMessagesView.swift
//  YoddChatGpt
//
//  Created by Ale on 30/01/23.
//

import SwiftUI

struct EmptySavedMessagesView: View {
    var body: some View {
        Spacer()
        Text("🤖 No saved messags").foregroundColor(.secondary)
        Spacer()
    }
}

struct EmptySavedMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySavedMessagesView()
    }
}
