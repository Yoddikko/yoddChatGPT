/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  AILibrariesList.swift
//  YoddChatGpt
//
//  Created by Ale on 21/02/23.
//

import SwiftUI

struct AILibrariesList: View {
    @State var library: AILibrary = AIChatViewModel.shared.getSelectedLibrary()
    var libraries: [AILibrary] = [.OpenAISwift, .ChatGPT]
    var body: some View {
        VStack {
            List {
                Picker("Library", selection: $library) {
                    ForEach(libraries, id: \.self) { lib in
                        Text(lib.rawValue).tag(lib)
                    }
                }
                NavigationLink("OpenAISwift library", destination: AIModelTypesList())
                NavigationLink("ChatGPT library", destination: ChatGPTSwiftModelTypesList())
                
            }
            
        }.onChange(of: library) { newValue in
            AIChatViewModel.shared.changeLibrary(AILibrary: newValue)
//            print(newValue)
//            print(OpenAIViewModel.shared.selectedAILibrary)
//            print(AIChatViewModel.shared.getSelectedLibrary())
        }
        
        .onAppear {
            self.library = AIChatViewModel.shared.getSelectedLibrary()
        }
        
    }
}

struct AILibrariesList_Previews: PreviewProvider {
    static var previews: some View {
        AILibrariesList()
    }
}
