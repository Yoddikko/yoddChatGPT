//
//  MessagesView.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import SwiftUI

struct MessagesView: View {
    
    // MARK: - Environmental objects and fetch requests
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var messages : FetchedResults<Message>
    @Environment(\.dismiss) var dismiss
    
    
    @ObservedObject var chatColors = ThemeViewModel.shared

//    @ObservedObject var speechSynthesizer = SpeechSynthesizer()

    
    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                if isNewDate() {
                    Text(getCurrentDateAsString())
                        .padding(10)
                        .font(.callout)
                        .background {
                            RoundedRectangle(cornerRadius: 15).foregroundColor(.accentColor.opacity(0.2))
                        }
                }
                ForEach (messages) { message in
                    if message.sender == "user" {
                        VStack {
                            HStack {
                                Spacer()
                                createUserMessageBubble(text: message.body!, primaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).0, secondaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).1)
                            }
                            HStack {
                                Spacer()
                                createTimeStamp(date: message.date!)
                            }
                        }
                        .id(message.id)
                        
                    } else {
                        VStack {
                            HStack() {
                                BotMessageBubble(primaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).0, secondaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).1, message: message, type: message.type == "text" ? .text : .error)
                                Spacer()
                            }
                            HStack {
                                createTimeStamp(date: message.date!)
                                Spacer()
                            }
                        }
                        .id(message.id)
                        
                    }
                }
                
                .onAppear{
                    value.scrollTo(messages.last?.id, anchor: .bottom)
                    
                }
                
                .onChange(of: messages.count) { _ in
                    withAnimation(.easeIn(duration: 0.5)) {
                        value.scrollTo(messages.last?.id, anchor: .bottom)
                    }
                }
            }.scrollDismissesKeyboard(.interactively)
            
        }
    }
    
    ///This function checks using user defaults if there is already a message in today's date (day, month and year).
    ///- Returns: True if there is no message in today's date and false if there's already a message in today's date.
    func isNewDate () -> Bool {
        let lastDate = UserDefaults.standard.object(forKey: "LastDate") as? Date
        if messages.last?.date != lastDate {
            UserDefaults.standard.set(Date(), forKey: "LastDate")
            return true
        } else {
            return false
        }
    }
    ///This function returns today's date as string in the "MM/dd/yyyy"  format .
    ///- Returns: True if there is no message in today's date and false if there's already a message in today's date.
    func getCurrentDateAsString () -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }

}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
