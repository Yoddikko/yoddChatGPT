//
//  NewMessageView.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import SwiftUI


/**
 This is the view of the TextField that manages also the sending and recieving of a message.

 - Version: 0.1

 */
struct NewMessageView: View {
    // MARK: - Environmental objects
    @Environment(\.dismiss) var dismiss
    @Environment (\.managedObjectContext) var managedObjectContext

    // MARK: - Sending message properties
    ///This is the text written in the textfield
    @Binding var text : String
    ///This is what manages the focus state of the keyboard
    @FocusState var textIsFocused : Bool
    ///Here are stored the messages sent and recieved alongside with CoreData
    @State var models = [TemporaryMessage]()

    // MARK: - ViewModels
    var audioPlayer = AudioPlayer()
    @ObservedObject var openAIViewModel = OpenAIViewModel()


    var body: some View {
        HStack {
            TextField("Ask me something...", text: $text)
                .focused($textIsFocused)
            //                    .lineLimit(6)
            Button(action: {
                send()
            }, label: {
                Image(systemName: "arrow.right.circle.fill").resizable().frame(width: 30, height: 30)
            })
            
            //TEMPORARY BUTTON
            Button(action: {
                DataController.shared.deleteData(context: managedObjectContext)
            }, label: {
                Image(systemName: "trash").resizable().frame(width: 30, height: 30)
            })

        }.padding()
            .onAppear{
                openAIViewModel.setup()
            }

    }
    
    
    /**
     This is the function that manages the sending and recieving of messages using `CoreData` and `OpenAIViewModel`.
     
     It gets the text to send from the variable `text` inside the view and the first thing it does is to see if the text is empty. If the text is empty it exits the function otherwise it continues.
     
     The message is both saved in CoreData and in a temporary message array. After that the API call is made using OpenAIViewModel. Then the result of the API call will be saved within CoreData and in the temporary messages.

     - Version: 0.1
     */
    func send() {
        //Checks if the text is empty
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        //Saves the user message
        let userMessage = TemporaryMessage(body: text, sender: .user)
        DataController.shared.addMessage(body: userMessage.body, sender: "user", type: text,  context: managedObjectContext)
        audioPlayer.playMessageSound(sender: .user)

        //API call
        openAIViewModel.send(text: text, completion: { response, messageType  in
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
        dismiss()
        self.text = ""
    }
}

struct NewMessageView_Previews: PreviewProvider {
    @FocusState var textIsFocused : Bool
    static var previews: some View {
        ZStack {
            NewMessageView(text: .constant("Text"))
        }
    }
}
