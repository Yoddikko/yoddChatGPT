/*
 The MIT License (MIT)
 
 Copyright (c) 2023 Alessio Iodice
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var messages: FetchedResults<Message>
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Properties
    @ObservedObject var chatColors = ThemeViewModel.shared
    @State var placeHolderUUID = UUID()
    @Binding var messageIsLoading: Bool
    
    var body: some View {
        ScrollViewReader { value in
            if #available(iOS 16.0, *) {
                ScrollView {
                    if isNewDate() {
                        Text(getCurrentDateAsString())
                        //                        .padding(10)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(8)
                            .background(
                                .ultraThickMaterial,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                            )
                    }
                    ForEach (messages) { message in
                        if message.sender == "user" {
                            VStack {
                                HStack {
                                    Spacer()
                                    UserMessageBubble(message: message, primaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).0, secondaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).1)
                                }
                                HStack {
                                    Spacer()
                                    createUserTimeStamp(date: message.date!)
                                }
                            }
                            .id(message.id)
                        } else {
                            VStack {
                                HStack() {
                                    BotMessageBubble(messageState: message.saved, primaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).0, secondaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).1, message: message, type: message.type == "text" ? .text : .error)
                                    Spacer()
                                }
                                HStack {
                                    createBotTimeStamp(date: message.date!)
                                    if AIChatViewModel.shared.showModelType {
                                        createModelTypeStamp(modelType: message.chatModel ?? "")
                                    }
                                    Spacer()
                                }
                            }
                            .onChange(of: message.saved, perform: { newValue in
                                message.saved = newValue
                            })
                            .id(message.id)
                        }
                    }
                    .onAppear{
                        value.scrollTo(messages.last?.id, anchor: .bottom)
                    }
                    
                    .onChange(of: messages.count) { _ in
                        withAnimation(.easeIn(duration: 0.5)) {
                            if messages.last?.sender == "user" {
                                value.scrollTo(placeHolderUUID, anchor: .bottom)
                            } else {
                                value.scrollTo(messages.last?.id, anchor: .bottom)
                                
                            }
                        }
                    }
                    
                    if messages.last?.sender == "user" && messageIsLoading  {
                        HStack {
                            BotLoadingMessage( secondaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).1).id(placeHolderUUID)
                            Spacer().id(placeHolderUUID)
                        }.id(placeHolderUUID)
                    }
                }.scrollDismissesKeyboard(.interactively)
            } else {
                // Fallback on earlier versions
            }
            
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
    ///This function returns today's date as string.
    func getCurrentDateAsString () -> String {
        return Date.now.formatted(date: .complete, time: .omitted)
    }
    
}

struct MessagesViewOlderiOS: View {
    
    // MARK: - Environmental objects and fetch requests
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var messages: FetchedResults<Message>
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Properties
    @ObservedObject var chatColors = ThemeViewModel.shared
    
    @State var placeHolderUUID = UUID()
    @Binding var messageIsLoading: Bool
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                if isNewDate() {
                    Text(getCurrentDateAsString())
                    //                        .padding(10)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(8)
                        .background(
                            .ultraThickMaterial,
                            in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                        )
                }
                ForEach (messages) { message in
                    if message.sender == "user" {
                        VStack {
                            HStack {
                                Spacer()
                                UserMessageBubble(message: message, primaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).0, secondaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).1)
                            }
                            HStack {
                                Spacer()
                                createUserTimeStamp(date: message.date!)
                            }
                        }
                        .id(message.id)
                    } else {
                        VStack {
                            HStack() {
                                BotMessageBubble(messageState: message.saved, primaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).0, secondaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).1, message: message, type: message.type == "text" ? .text : .error)
                                Spacer()
                            }
                            HStack {
                                createBotTimeStamp(date: message.date!)
                                if AIChatViewModel.shared.showModelType {
                                    createModelTypeStamp(modelType: message.chatModel ?? "")
                                }
                                Spacer()
                            }
                        }
                        .onChange(of: message.saved, perform: { newValue in
                            message.saved = newValue
                        })
                        .id(message.id)
                    }
                }
                .onAppear{
                    value.scrollTo(messages.last?.id, anchor: .bottom)
                }
                
                .onChange(of: messages.count) { _ in
                    withAnimation(.easeIn(duration: 0.5)) {
                        //                        value.scrollTo(messages.last?.id, anchor: .bottom)
                        //                        if messages.last?.sender == "user" {
                        value.scrollTo(placeHolderUUID, anchor: .bottom)
                        value.scrollTo(messages.last?.id, anchor: .bottom)
                        //                        }
                    }
                }
                
                if messages.last?.sender == "user" && messageIsLoading {
                    HStack {
                        BotLoadingMessage( secondaryColor: chatColors.getColorsFromThemeEnum(theme: chatColors.theme).1).id(placeHolderUUID)
                        Spacer().id(placeHolderUUID)
                    }.id(placeHolderUUID)
                }
            }
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
    ///This function returns today's date as string.
    func getCurrentDateAsString () -> String {
        return Date.now.formatted(date: .complete, time: .omitted)
    }
    
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            MessagesView(messageIsLoading: .constant(false))
        } else {
        }
    }
}
