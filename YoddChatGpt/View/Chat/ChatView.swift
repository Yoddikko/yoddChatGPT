/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


//
//  ChatView.swift
//  YoddChatGpt
//
//  Created by Ale on 17/01/23.
//

import SwiftUI
import CoreData

/**
 This is the view that contains all the other chat related views.
 
 - Version: 0.2
 
 */
struct ChatView: View {
    
    @State var showPrompt = false
    
    // MARK: - Sending message properties
    ///This is the text written in the textfield
    @State var text : String = ""
    ///This is what manages the focus state of the keyboard
    @FocusState var textIsFocused : Bool
    ///Here are stored the messages sent and recieved alongside with CoreData
    @State var models = [TemporaryMessage]()
    
    // MARK: - ViewModels
    var audioPlayer = AudioPlayer()
    @ObservedObject var openAIViewModel = OpenAIViewModel()
    
    // MARK: - Environmental objects and fetch requests
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var messages : FetchedResults<Message>
    
    var body: some View {
        NavigationView {
            VStack {
                if messages.isEmpty {
                    //Shows an empty chat view
                    EmptyChatView()
                } else {
                    //View with messages
                    if #available(iOS 16.0, *) {
                        MessagesView()
                            .padding(.top, 1)
                            .onTapGesture {
                                textIsFocused = false
                            }
                    } else {
                        MessagesViewOlderiOS()
                            .padding(.top, 1)
                            .onTapGesture {
                                textIsFocused = false
                            }
                    }
                }
                HStack {
                    TextField("Ask me something...", text: $text)
                        .focused($textIsFocused)
                        .padding(.vertical, 20)
                    Button(action: {
                        sendFromKeyboard()
                    }, label: {
                        Image(systemName: "arrow.right.circle.fill").resizable().frame(width: 30, height: 30)
                    })
                }.padding()
                    .onAppear{
                        OpenAIViewModel.shared.setup()
                    }
                    .onDisappear{
                        textIsFocused = false
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            NavigationLink(destination: {
                                SettingsView()
                            }, label: {
                                Image(systemName: "gear")
                            })
                        }
                    }
            }
        }
        
        
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    
    /**
     This is the function that manages the sending and recieving of messages using `CoreData` and `OpenAIViewModel`.
     
     It gets the text to send from the variable `text` inside the view and the first thing it does is to see if the text is empty. If the text is empty it exits the function otherwise it continues.
     
     The message is both saved in CoreData and in a temporary message array. After that the API call is made using OpenAIViewModel. Then the result of the API call will be saved within CoreData and in the temporary messages.
     
     - Version: 0.1
     */
    func sendFromKeyboard() {
        //Checks if the text is empty
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        //Saves the user message
        let userMessage = TemporaryMessage(body: text, sender: .user)
        DataController.shared.addMessage(body: userMessage.body, sender: "user", type: text,  context: managedObjectContext)
        audioPlayer.playMessageSound(sender: .user)
        //API call
        OpenAIViewModel.shared.send(text: text, completion: { response, messageType  in
            DispatchQueue.main.async {
                
                //Saves the bot message and checks if it's an error message or a normal text
                if messageType == .text {
                    var botMessage = TemporaryMessage(body: response, sender: .bot)
                    botMessage.body = botMessage.body.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.models.append(botMessage)
                    DataController.shared.addMessage(body: botMessage.body, sender: "bot", type: "text", context: managedObjectContext)
                    audioPlayer.playMessageSound(sender: .bot)
                } else if messageType == .error {
                    var botMessage = TemporaryMessage(body: response, sender: .bot)
                    botMessage.body = botMessage.body.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.models.append(botMessage)
                    DataController.shared.addMessage(body: botMessage.body, sender: "bot", type: "error", context: managedObjectContext)
                    audioPlayer.playMessageSound(sender: .bot)
                }
            }
        })
        self.text = ""
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

