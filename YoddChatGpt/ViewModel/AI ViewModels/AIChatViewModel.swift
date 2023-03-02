/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVEvNT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  OpenAIViewModel.swift
//  YoddChatGpt
//
//  Created by Ale on 17/01/23.
//

import Foundation
import OpenAISwift // External framework
import ChatGPTSwift // External framework
import SwiftUI
/**
 This is the viewmodel that manages the implementation of AI libraries .
 
 It all started with just one library, so I wrote this viewmodel to be for that single library. Then I started adding more and I had to make this the main viewmodel that manages all the libraries. It is a bit messy, all the libraries should be inizialized here, and then having the functions of every single library in another file, as extension of this class.
 

 - Version: 0.4
 
 */
final class AIChatViewModel: ObservableObject {
    
    static var shared = AIChatViewModel()
    
    ///This variable keeps in the appstorage a bool value that if it's true it show the model type of the AI in the chat
    @AppStorage ("showModelType") var showModelType: Bool = false
    
    //MARK: OpenAISwift properties
    var openAIModelType: OpenAIModelType = .gpt3(.davinci)
    
    ///Client that manages the OpenAISwift library functions
    @Published var OpenAISwiftClient: OpenAISwift? //this is for the OpenAISwift library, it is the default one because all the app initially was based just on this library
  
    //MARK: ChatGPTSwift properties
    
    ///Client that manages the ChatGPTSwift library functions
    @Published var chatGPTSwiftClient: ChatGPTAPI?
    
    ///Selected library is the currently library in use (OpenAISwift, ChatGPTSwift etc..)
    @Published var selectedAILibrary: AILibrary?
    
    ///This is the initializer that initialize all the different libraries
    func setup() {
        ///This is the library in use saved as a string in the user defaults
        let AILibraryUserDefaults = UserDefaults.standard.string(forKey: "AILibrary")
        selectedAILibrary = getLibraryFromString(string: AILibraryUserDefaults ?? "")
        
        OpenAISwiftClient = OpenAISwift(authToken: UserDefaults.standard.string(forKey: "token") ?? "")
        
        chatGPTSwiftClient = ChatGPTAPI(apiKey: UserDefaults.standard.string(forKey: "token") ?? "")
        
        //This pretty ugly chunk of function gets the model type of OpenAISwift and sets it
        let openAIModelTypeString: String = UserDefaults.standard.string(forKey: "openAiModelType") ?? ""
        if !openAIModelTypeString.isEmpty {
            self.openAIModelType = getOpenAIModelTypeFromString(openAIModelTypeString: openAIModelTypeString)
        } else {
            self.openAIModelType = .gpt3(.davinci)
        }
    }
    
    //MARK: Library
    func getLibraryFromString (string: String) -> AILibrary {
        switch string {
        case "OpenAISwift":
            return .OpenAISwift
        case "ChatGPT":
            return .ChatGPT
        default:
            return .ChatGPT
        }
    }
    
    func changeLibrary (AILibrary: AILibrary) {
        self.selectedAILibrary = AILibrary
        UserDefaults.standard.set(AILibrary.rawValue, forKey: "AILibrary")
    }
    
    func getSelectedLibrary () -> AILibrary {
        return selectedAILibrary!
    }
    
    //MARK: OpenAISwift properties
    let allOpenAISwiftModels: [(OpenAIModelType, String)] = [
        (.gpt3(.davinci), "Most capable GPT-3 model. Can do any task the other models can do, often with higher quality, longer output and better instruction-following. Also supports inserting completions within text."),
        (.gpt3(.ada), "Capable of very simple tasks, usually the fastest model in the GPT-3 series, and lowest cost."),
        (.gpt3(.babbage), "Capable of straightforward tasks, very fast, and lower cost."),
        (.gpt3(.curie), "Very capable, but faster and lower cost than GPT3 davinci"),
        (.codex(.davinci), "Most capable Codex model. Particularly good at translating natural language to code. In addition to completing code, also supports inserting completions within code."),
        (.codex(.cushman), "Almost as capable as davinci Codex, but slightly faster. This speed advantage may make it preferable for real-time applications.")
    ]

}
