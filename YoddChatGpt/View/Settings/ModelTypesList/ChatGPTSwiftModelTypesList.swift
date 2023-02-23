/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
    @State var selectedLibrary: AILibrary? = nil
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
                self.selectedLibrary = AIChatViewModel.shared.getSelectedLibrary()
            }
            
            HStack {
                Text("ChatGPT is the same API of the web version. It uses the ChatGPTSwift library and most importantly it can remember the conversation. It speaks only english and in general could be less stable than OpenAISwift library.")
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
