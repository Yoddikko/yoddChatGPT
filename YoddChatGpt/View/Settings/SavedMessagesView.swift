//
//  SavedMessagesView.swift
//  YoddChatGpt
//
//  Created by Ale on 30/01/23.
//

import SwiftUI

struct SavedMessagesView: View {
    
    @Environment (\.managedObjectContext) var managedObjectContext
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var messages : FetchedResults<Message>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "saved == true")) var savedMessages : FetchedResults<Message>
    var theme = ThemeViewModel.shared.theme

    var body: some View {
        if savedMessages.isEmpty {
            EmptySavedMessagesView()
        } else {
            ScrollView {
                ForEach (savedMessages) { message in
                    VStack {
                        HStack {
                            BotMessageBubble(messageState: message.saved, primaryColor: ThemeViewModel.shared.getColorsFromThemeEnum(theme: theme).0, secondaryColor: ThemeViewModel.shared.getColorsFromThemeEnum(theme: theme).1, message: message, type: .text)
                            Spacer()
                        }
                        HStack {
                            createFullTimeStamp(date: message.date!)
                            createTimeStamp(date: message.date!)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct SavedMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedMessagesView()
    }
}
