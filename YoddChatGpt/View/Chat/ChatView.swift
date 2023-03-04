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
import OpenAI

/**
 This is the view that contains all the other chat related views.
 
 - Version: 0.2
 
 */
struct ChatView: View {
    
    @State var showPrompt = false
    
    // MARK: - Sending message properties
    ///This is the text written in the textfield
    @State var text: String = ""
    ///This is what manages the focus state of the keyboard
    @FocusState var textIsFocused: Bool
    ///Here are stored the messages sent and recieved alongside with CoreData
    @State var models = [TemporaryMessage]()
    
    @State var messageIsLoading = false
    
    // MARK: - ViewModels
    var audioPlayer = AudioPlayer()
    @ObservedObject var aiChatViewModel = AIChatViewModel()
    
    // MARK: - Environmental objects and fetch requests
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var messages: FetchedResults<Message>
    
    var body: some View {
        NavigationView {
            VStack {
                if messages.isEmpty {
                    //Shows an empty chat view
                    EmptyChatView()
                } else {
                    //View with messages
                    if #available(iOS 16.0, *) {
                        MessagesView(messageIsLoading: $messageIsLoading)
                            .padding(.top, 1)
                            .onTapGesture {
                                textIsFocused = false
                            }
                    } else {
                        MessagesViewOlderiOS(messageIsLoading: $messageIsLoading)
                            .padding(.top, 1)
                            .onTapGesture {
                                textIsFocused = false
                            }
                    }
                }
                HStack {
                    if #available(iOS 16.0, *) {
                        TextField("Ask me something...", text: $text, axis: .vertical)
                            .focused($textIsFocused)
                            .padding(.vertical, 10)
                            .onTapGesture {
                                textIsFocused = true
                            }
                    } else {
                        TextField("Ask me something...", text: $text)
                            .lineLimit(5)
                            .focused($textIsFocused)
                            .padding(.vertical, 10)
                            .onTapGesture {
                                textIsFocused = true
                            }
                    }
                    if aiChatViewModel.outputType == .text {
                        Button(action: {
                            aiChatViewModel.outputType = .image
                            AIChatViewModel.shared.outputType = .image
                        }, label: {
                            Image(systemName: "photo.circle.fill").resizable().frame(width: 30, height: 30)
                        })
                    }
                    HStack {
                        if aiChatViewModel.outputType == .image {
                            Button(action: {
                                aiChatViewModel.outputType = .text
                                AIChatViewModel.shared.outputType = .text
                            }, label: {
                                Image(systemName: "message.circle.fill").resizable().frame(width: 30, height: 30)
                            })
                        }
                        Button(action: {
                            if aiChatViewModel.outputType == .image {
                                sendFromKeyboardOutputImage()
                            } else {
                                sendFromKeyboardOutputText()
                            }
                        }, label: {
                            Image(systemName: "arrow.right.circle.fill").resizable().frame(width: 30, height: 30)
                        })
                    }
                }.padding()
                    .onAppear{
                        AIChatViewModel.shared.setup()
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
        
//        .onAppear {
//            var messageAppStore1 = TemporaryMessage(body: "THE APP IS NOW OUT ON THE APPSTORE 🎉", sender: .bot)
//            var messageAppStore2 = TemporaryMessage(body: "Download it here", sender: .bot)
//            var messageAppStore3 = TemporaryMessage(body: "https://apps.apple.com/us/app/yoddaichat/id1672839275", sender: .bot)
//
            
//            var message1 = TemporaryMessage(body: "Tell me something crazy about the universe", sender: .user)
//            var message2 = TemporaryMessage(body: "Did you know that the universe is expanding at an accelerating rate? Scientists estimate that the universe is doubling in size ever 10 to 20 billion years.", sender: .bot)
//            var message3 = TemporaryMessage(body: "No way, tell me more, please!", sender: .user)
//            var message4 = TemporaryMessage(body: "Scientists have also discovered that the universe is filled with dark matter and dark energy, which make up 95% of the universe. They are still trying to understand what these mysterious substances are", sender: .bot)
//            var message5 = TemporaryMessage(body: "That's amazing, thank you bot ❤️", sender: .user)
//            var message6 = TemporaryMessage(body: "You're welcome! It's always a pleasure to share interesting facts about the universe.", sender: .bot)
//            var message1 = TemporaryMessage(body: "Dimmi qualcosa di assurdo sull'universo", sender: .user)
//            var message2 = TemporaryMessage(body: "Sapevate che l'universo si sta espandendo a un ritmo sempre più rapido? Gli scienziati stimano che l'universo raddoppia le sue dimensioni ogni 10-20 miliardi di anni.", sender: .bot)
//            var message3 = TemporaryMessage(body: "Assurdo, dimmi di più per favore!", sender: .user)
//            var message4 = TemporaryMessage(body: "Gli scienziati hanno anche scoperto che l'universo è pieno di materia ed energia oscura, che costituiscono il 95% dell'universo. Si sta ancora cercando di capire cosa siano queste misteriose sostanze.", sender: .bot)
//            var message5 = TemporaryMessage(body: "E' fantastico, grazie bot ❤️", sender: .user)
//            var message6 = TemporaryMessage(body: "Non c'è di che! È sempre un piacere condividere fatti interessanti sull'universo.", sender: .bot)
//            DataController.shared.addMessage(body: message1.body, sender: "user", type: "text", outputType: .text, context: managedObjectContext)
//            DataController.shared.addMessage(body: message2.body, sender: "bot", type: "text", outputType: .text, context: managedObjectContext)
//            DataController.shared.addMessage(body: message3.body, sender: "user", type: "text", outputType: .text, context: managedObjectContext)
//            DataController.shared.addMessage(body: message4.body, sender: "bot", type: "text", outputType: .text, context: managedObjectContext)
//            DataController.shared.addMessage(body: message5.body, sender: "user", type: "text", outputType: .text, context: managedObjectContext)
//            DataController.shared.addMessage(body: message6.body, sender: "bot", type: "text", outputType: .text, context: managedObjectContext)

//        }
        
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    //TODO: Refactor the sending function maybe using async await
    
    /**
     This is the function that manages the sending and recieving of messages using `CoreData` and `OpenAIViewModel`.
     
     It gets the text to send from the variable `text` inside the view and the first thing it does is to see if the text is empty. If the text is empty it exits the function otherwise it continues.
     
     The message is both saved in CoreData and in a temporary message array. After that the API call is made using OpenAIViewModel. Then the result of the API call will be saved within CoreData and in the temporary messages.
     
     - Version: 0.2
     */
    func sendFromKeyboardOutputText() {
        //Checks if the text is empty
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        //Saves the user message
        let userMessage = TemporaryMessage(body: text, sender: .user)
        DataController.shared.addMessage(body: userMessage.body, sender: "user", type: text,  outputType: .text, context: managedObjectContext)
        audioPlayer.playMessageSound(sender: .user)
        //API call
        messageIsLoading = true
        if AIChatViewModel.shared.selectedAILibrary == .ChatGPT {
            let library: AILibrary = .ChatGPT
            AIChatViewModel.shared.sendChatGPTSwift(text: text, completion: {
                response, messageType  in
                    DispatchQueue.main.async {
                        
                        //Saves the bot message and checks if it's an error message or a normal text
                        if messageType == .text {
                            var botMessage = TemporaryMessage(body: response, sender: .bot)
                            botMessage.body = botMessage.body.trimmingCharacters(in: .whitespacesAndNewlines)
                            self.models.append(botMessage)
                            DataController.shared.addMessage(body: botMessage.body, sender: "bot", type: "text", aiLibrary: library, outputType: .text, context: managedObjectContext)
                            audioPlayer.playMessageSound(sender: .bot)
                        } else if messageType == .error {
                            var botMessage = TemporaryMessage(body: response, sender: .bot)
                            botMessage.body = botMessage.body.trimmingCharacters(in: .whitespacesAndNewlines)
                            self.models.append(botMessage)
                            DataController.shared.addMessage(body: botMessage.body, sender: "bot", type: "error", aiLibrary: library, outputType: .text, context: managedObjectContext)
                            audioPlayer.playMessageSound(sender: .bot)
                        }
                        messageIsLoading = false
                    }
            })
        }
        else if AIChatViewModel.shared.selectedAILibrary == .OpenAISwift {
            guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }

            let library: AILibrary = .OpenAISwift

            AIChatViewModel.shared.sendOpenAIViewModel(text: text, completion: { response, messageType  in
                DispatchQueue.main.async {
                    
                    //Saves the bot message and checks if it's an error message or a normal text
                    if messageType == .text {
                        var botMessage = TemporaryMessage(body: response, sender: .bot)
                        botMessage.body = botMessage.body.trimmingCharacters(in: .whitespacesAndNewlines)
                        self.models.append(botMessage)
                        DataController.shared.addMessage(body: botMessage.body, sender: "bot", type: "text", aiLibrary: library, outputType: .text, context: managedObjectContext)
                        audioPlayer.playMessageSound(sender: .bot)
                    } else if messageType == .error {
                        var botMessage = TemporaryMessage(body: response, sender: .bot)
                        botMessage.body = botMessage.body.trimmingCharacters(in: .whitespacesAndNewlines)
                        self.models.append(botMessage)
                        DataController.shared.addMessage(body: botMessage.body, sender: "bot", type: "error", aiLibrary: library, outputType: .text, context: managedObjectContext)
                        audioPlayer.playMessageSound(sender: .bot)
                    }
                    messageIsLoading = false
                }
                
                }
            )}
        self.text = ""
    }
    
    func sendFromKeyboardOutputImage() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        AIChatViewModel.shared.outputType = .image
        let userMessage = TemporaryMessage(body: text, sender: .user)
        DataController.shared.addMessage(body: userMessage.body, sender: "user", type: text, outputType: .none, context: managedObjectContext)
        audioPlayer.playMessageSound(sender: .user)
        messageIsLoading = true
        let query = OpenAI.ImagesQuery(prompt: text, n: 1, size: "1024x1024")
        AIChatViewModel.shared.openAIClient.images(query: query) { result in
            //Handle result here
            do {
                let resultData = try result.get()
//                let image = saveImage(url: resultData.data.first!.url)
                let url = resultData.data.first!.url
                let task = URLSession.shared.dataTask(with: URL(string: url)!) { result,response,error  in
                    if let result = result {
                        if UIImage(data: result) != nil {
                            let image = UIImage(data: result)!
                            DataController.shared.addMessage(body: "", sender: "bot", type: "image", data: image, outputType: .image, context: managedObjectContext)
                            messageIsLoading = false
                        }
                    }
                }
                task.resume()

            } catch {
                //error
                DataController.shared.addMessage(body: "Error while generating image", sender: "bot", type: "error", outputType: .text, context: managedObjectContext)
                messageIsLoading = false
            }
        }
        self.text = ""
    }
}

//func saveImage (url: String) -> UIImage? {
//    var image = UIImage()
//    let url = URL(string: url)!
//    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//        if let error = error {
//            // handle error
//            return
//        }
//        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//            // handle error
//            return
//        }
//        if let data = data {
//            if UIImage(data: data) != nil {
//                let tmpImage = UIImage(data: data)!
//                image = tmpImage
////                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//            }
//        }
//    }
//    task.resume()
//    return image
//}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
