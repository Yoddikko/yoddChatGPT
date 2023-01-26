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
    
    var audioPlayer = AudioPlayer()
    
    @FocusState var textIsFocused : Bool
    
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
                        if isNewDate() {
                            Text(getCurrentDateAsString())
                                .padding(10)
                                .font(.callout)
                                .background {
                                    RoundedRectangle(cornerRadius: 15).foregroundColor(.blue.opacity(0.2))
                                }
                        }
                        ForEach (messages) { message in
                            if message.sender == "user" {
                                VStack {
                                    HStack {
                                        Spacer()
                                        createUserMessageBubble(text: message.body!)
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
                                        createBotMessageBubble(text: message.body!)
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
                .padding(.top, 1)
                
                .onTapGesture {
                    textIsFocused = false
                }
                
            }
            //                Spacer()
        }
        HStack {
            TextField("Ask me something...", text: $text)
                .focused($textIsFocused)
            //                    .lineLimit(6)
            Button(action: {
                send()
            }, label: {
                Image(systemName: "arrow.right.circle.fill").resizable().frame(width: 30, height: 30)
            })
        }.padding()
        
        //        .onTapGesture {
        //            textIsFocused = false
        //        }
        
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
        audioPlayer.playMessageSound(sender: .user)

        openAIViewModel.send(text: text, completion: { response in
            DispatchQueue.main.async {
                var botMessage = TemporaryMessage(body: response, sender: .bot)
                botMessage.body = botMessage.body.trimmingCharacters(in: .whitespacesAndNewlines)
                self.models.append(botMessage)
                DataController.shared.addMessage(body: botMessage.body, sender: "bot", context: managedObjectContext)
                audioPlayer.playMessageSound(sender: .bot)
                
            }
        })
        dismiss()
        
        self.text = ""
        
        
    }
    
    func isNewDate () -> Bool {
        let lastDate = UserDefaults.standard.object(forKey: "LastDate") as? Date
        if messages.last?.date != lastDate {
            UserDefaults.standard.set(Date(), forKey: "LastDate")
            return true
        } else {
            return false
        }
    }
}

struct ChatView_Previews2: PreviewProvider {
    static var previews: some View {
        ChatView()
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
@ViewBuilder
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

@ViewBuilder
func createTimeStamp (date : Date) -> some View {
    Text(date, style: .time)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.horizontal)
}


func getCurrentDateAsString () -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter.string(from: date)
}
