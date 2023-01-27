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

 - Version: 0.1

 */
struct ChatView: View {
    
    // MARK: - Environmental objects and fetch requests
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var messages : FetchedResults<Message>
    
    // MARK: - Properties
    @FocusState var textIsFocused : Bool
    @State var text = ""
    
    
    var body: some View {
        NavigationStack {
        VStack {
            if messages.isEmpty {
                //Shows an empty chat view
                EmptyChatView()
            } else {
                //View with messages
                MessagesView()
                
                    .padding(.top, 1)
                
                    .onTapGesture {
                        textIsFocused = false
                    }
            }
        }
            //View with text field to send a message
            NewMessageView(text: $text, textIsFocused: _textIsFocused)

        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    SettingsView()
                }, label: {
                    Image(systemName: "list.bullet")
                })
            }
        }


    }
        .navigationViewStyle(StackNavigationViewStyle())
        




    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

