//
//  ChatGPTSwiftModelTypesList.swift
//  YoddChatGpt
//
//  Created by Ale on 21/02/23.
//

import SwiftUI
import OpenAISwift

// TODO: - REFACTOR
// MARK: - THIS VIEW AND THE FUNCTIONS OF OPENAIVIEWMODEL THAT USES ARE A MESS, THIS AND THE VIEWMODEL WILL HAVE HEAVY REVAMPS BUT ARE OK FOR NOW

struct ChatGPTSwiftModelTypesList: View {
    @State var selectedLibrary : AILibrary? = nil
    var body: some View {
        VStack {
            List (0..<1) { _ in
                HStack {
                    Text("ChatGPT")
                    Spacer()
                    if selectedLibrary == .ChatGPT {
                        Image(systemName: "checkmark.circle.fill")
                            .scaledToFit()
                            .foregroundColor(ThemeViewModel.shared.accentColor)
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .scaledToFit()
                            .foregroundColor(.gray)
                    }
                    
                }
                
            }.onAppear{
                self.selectedLibrary = OpenAIViewModel.shared.getSelectedLibrary()
                print(OpenAIViewModel.shared.getSelectedLibrary())
                print(selectedLibrary)
            }
            HStack {
                Text("ChatGPT is the same API of the web version. It uses the ChatGPTSwift library and most importantly it can remember the conversation. It speaks only english and in general could be less stable than the other library.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }.padding()
        }

    }
}

struct ChatGPTSwiftModelTypesList_preview: PreviewProvider {
    static var previews: some View {
        ChatGPTSwiftModelTypesList()
    }
}


