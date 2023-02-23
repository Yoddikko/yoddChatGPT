/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  ChatGPTSwift.swift
//  YoddChatGpt
//
//  Created by Ale on 23/02/23.
//

import SwiftUI


//MARK: ChatGPTSwift library
extension AIChatViewModel {
    
    ///Sending messages with the ChatGPTSwift library
    func sendChatGPTSwift(text: String, completion: @escaping((String, MessageType) -> Void)) {
        Task {
            do {
                let response = try await chatGPTSwiftClient?.sendMessage(text: text)
                let messageType : MessageType = .text
                print("ChatGPT: \(String(describing: response))")
                completion(response ?? "", messageType)
                
            } catch {
                print(error.localizedDescription)
                let messageType : MessageType = .error
                let response = "API error, check your connection or change model type"
                completion(response, messageType)
            }
        }
    }
    
}
