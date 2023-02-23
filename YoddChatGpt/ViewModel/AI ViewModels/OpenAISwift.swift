/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


//
//  OpenAISwift.swift
//  YoddChatGpt
//
//  Created by Ale on 23/02/23.
//

import SwiftUI
import OpenAISwift

//MARK: OpenAISwift library functions
extension AIChatViewModel {
    
    ///Sending messages with the OpenAISiwft library
    func sendOpenAIViewModel(text: String, completion: @escaping((String, MessageType) -> Void)) {
        print(self.openAIModelType)
        OpenAISwiftClient?.sendCompletion(with: text, model: self.openAIModelType, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                let messageType : MessageType = .text
                print("ChatGPT: \(output)")
                completion(output, messageType)
            case .failure(let error):
                let output = error.localizedDescription
                let messageType : MessageType = .error
                completion(output, messageType)
            }
        })
    }
    
    
    
    ///Function to set a token for OpenAISiwft
    func setTokenOpenAISwift(string: String) {
        self.OpenAISwiftClient = OpenAISwift(authToken: string)
        UserDefaults.standard.set(string, forKey: "token")
        setup()
    }
    
    //MARK: Model type functions
    func setOpenAIViewModelType(openAIModelTypeString : String) {
        self.openAIModelType = getOpenAIModelTypeFromString(openAIModelTypeString: openAIModelTypeString)
        UserDefaults.standard.set(openAIModelTypeString, forKey: "openAiModelType")
    }
    
    
    func getOpenAIModelTypeFromString (openAIModelTypeString : String) -> OpenAIModelType  {
        switch openAIModelTypeString {
        case "text-davinci-003":
            return .gpt3(.davinci)
        case "text-ada-001":
            return .gpt3(.ada)
        case "text-babbage-001":
            return .gpt3(.babbage)
        case "text-curie-001":
            return .gpt3(.curie)
        case "code-davinci-002":
            return .codex(.davinci)
        case "code-cushman-001":
            return .codex(.cushman)
        default:
            return .gpt3(.davinci)
        }
    }
    
    func getOpenAIModelNameFromString (openAIModelTypeString : String) -> String  {
        switch openAIModelTypeString {
        case "text-davinci-003":
            return "ChatGPT Davinci"
        case "text-ada-001":
            return "ChatGPT Ada"
        case "text-babbage-001":
            return "ChatGPT Babbage"
        case "text-curie-001":
            return "ChatGPT Curie"
        case "code-davinci-002":
            return "Codex Davinci"
        case "code-cushman-001":
            return "Codex Cushman"
        default:
            return "ChatGPT Davinci"
        }
        
    }
    
    func returnModelDescription (index : Int) -> String {
        return allOpenAISwiftModels[index].1
    }
    
    
}
