//
//  ChatView.swift
//  YoddChatGpt
//
//  Created by Ale on 17/01/23.
//

import SwiftUI
import CoreData

struct ChatView: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var messages : FetchedResults<Message>
    @Environment(\.dismiss) var dismiss
    
    
    
    
    @ObservedObject var openAIViewModel = OpenAIViewModel()
    @State var text = ""
    @State var models = [TemporaryMessage]()

    var body: some View {
        VStack {
            if messages.isEmpty {
                Spacer()
                Text("🤖 Bip bop ask me anything").foregroundColor(.secondary)
                Spacer()
            } else {
                ScrollViewReader { value in
                    ScrollView {
                        ForEach (messages) { message in
                            if message.sender == "user" {
                                HStack {
                                    Spacer()
                                    createUserMessageBubble(text: message.body!)
                                }
                                .id(message.id)

                            } else {
                                HStack() {
                                    createBotMessageBubble(text: message.body!)
                                    Spacer()
                                }
                                .id(message.id)

//                                    .onAppear {
//                                        DispatchQueue.main.async {
//                                        value.scrollTo(models.last?.id)
//                                    }
//                                }

                            }
                            
                        }
                        
                        .onChange(of: messages.count) { _ in
                            print("valore cambiato")
                            value.scrollTo(messages.last?.id, anchor: .bottom)
                        }
//                        .onAppear {
//                            value.scrollTo(models.last.id)
//                        }
                    }
                }
                Spacer()
            }
            HStack {
                TextField("Ask me something...", text: $text)
                    .lineLimit(6)
                Button(action: {
                    send()
                }, label: {
                    Image(systemName: "arrow.right.circle.fill").resizable().frame(width: 30, height: 30)
                })
            }.padding()
        }
        
            .onAppear{
                openAIViewModel.setup()
            }
    }
    
    
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let userMessage = TemporaryMessage(body: text, sender: .user)
        DataController.shared.addMessage(body: userMessage.body, sender: "user", context: managedObjectContext)
        openAIViewModel.send(text: text, completion: { response in
            DispatchQueue.main.async {
                var botMessage = TemporaryMessage(body: response, sender: .bot)
                botMessage.body = botMessage.body.trimmingCharacters(in: .whitespacesAndNewlines)
                self.models.append(botMessage)
                DataController.shared.addMessage(body: botMessage.body, sender: "bot", context: managedObjectContext)
            }
        })
        dismiss()

        self.text = ""

        
    }
}

struct ChatView_Previews2: PreviewProvider {
    static var previews: some View {
        ChatView2()
    }
}

@ViewBuilder
func createUserMessageBubble (text : String) -> some View {
    HStack() {
        Text(text)
            .multilineTextAlignment(.leading)
            .padding(.leading, 30)
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .padding(.trailing, 5)
    }.background {
        ZStack {
            RoundedRectangle(cornerRadius: 15).foregroundColor(.primary.opacity(0.1))
                .padding(.leading, 30).padding(.trailing, 5)

        }
    }
}

func createBotMessageBubble (text : String) -> some View {
    HStack() {
        Text(text)
            .multilineTextAlignment(.leading)
            .padding(.trailing, 30)
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .padding(.leading, 5)

    }.background {
        ZStack {
            RoundedRectangle(cornerRadius: 15).foregroundColor(.secondary.opacity(0.1))
                .padding(.trailing, 30).padding(.leading, 5)
        }
    }

}





