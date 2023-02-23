/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


//
//  AIModelTypesList.swift
//  YoddChatGpt
//
//  Created by Ale on 31/01/23.
//

import SwiftUI
import OpenAISwift

// TODO: - REFACTOR
// MARK: - THIS VIEW AND THE FUNCTIONS OF OPENAIVIEWMODEL THAT USES ARE A MESS, THIS AND THE VIEWMODEL WILL HAVE HEAVY REVAMPS BUT ARE OK FOR NOW

struct AIModelTypesList: View {
    
    @State private var selection = AIChatViewModel.shared.allOpenAISwiftModels.firstIndex { tuple in
        tuple.0.modelName == AIChatViewModel.shared.openAIModelType.modelName
    }
    @State var selectedLibrary : AILibrary? = nil
    var body: some View {
        
        List (0..<AIChatViewModel.shared.allOpenAISwiftModels.count, id: \.self, selection: $selection) { index in
            HStack {
                
                Text(AIChatViewModel.shared.getOpenAIModelNameFromString(openAIModelTypeString: AIChatViewModel.shared.allOpenAISwiftModels[index].0.modelName))
                Spacer()
                if selection == index {
                    if selectedLibrary == .OpenAISwift {
                        Image(systemName: "checkmark.circle.fill")
                            .scaledToFit()
                            .foregroundColor(ThemeViewModel.shared.accentColor)
                    }
                    else {
                        Image(systemName: "checkmark.circle.fill")
                            .scaledToFit()
                            .foregroundColor(.gray)

                    }
                }
                
            }.onChange(of: selection) { selection in
                AIChatViewModel.shared.setOpenAIViewModelType(openAIModelTypeString: AIChatViewModel.shared.allOpenAISwiftModels[selection!].0.modelName)
//                OpenAIViewModel.shared.setup()
            }
            .onAppear {
                self.selectedLibrary = AIChatViewModel.shared.getSelectedLibrary()
            }
        }

    }
}

struct ChatGPTModelTypesList_Previews: PreviewProvider {
    static var previews: some View {
        AIModelTypesList()
    }
}


