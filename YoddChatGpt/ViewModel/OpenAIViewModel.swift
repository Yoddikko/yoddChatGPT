//
//  OpenAIViewModel.swift
//  YoddChatGpt
//
//  Created by Ale on 17/01/23.
//

import Foundation
import OpenAISwift
import SwiftUI

/**
 This is the ViewModel that manages the OpenAISwift implementation.

 - Version: 0.2

 */
final class OpenAIViewModel : ObservableObject {
    
    private var client : OpenAISwift?
    
    var openAiModelType : OpenAIModelType = .gpt3(.davinci)
//    private var openAiModelTypeCodex : OpenAIModelType.Codex?
//    private var openAiModelTypeGPT3 : OpenAIModelType.GPT3?

    static var shared = OpenAIViewModel()
    
    @AppStorage ("showModelType") var showModelType : Bool = false

    
    @Published var token : OpenAISwift?
    @Published var tokenUserDefaults : String = UserDefaults.standard.string(forKey: "token") ?? ""

    func setup() {
        token = OpenAISwift(authToken: UserDefaults.standard.string(forKey: "token") ?? "")
        let openAIModelTypeString : String =  UserDefaults.standard.string(forKey: "openAiModelType") ?? ""
        if !openAIModelTypeString.isEmpty {
            self.openAiModelType = getOpenAIModelTypeFromString(openAIModelTypeString: openAIModelTypeString)
        } else {
            self.openAiModelType = .gpt3(.davinci)
        }
    }
    
    func send(text: String, completion: @escaping((String, MessageType) -> Void)) {
        print(self.openAiModelType)
        token?.sendCompletion(with: text, model: self.openAiModelType, maxTokens: 500, completionHandler: { result in
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
    
    
    func setOpenAIViewModelType(openAIModelTypeString : String) {
        self.openAiModelType = getOpenAIModelTypeFromString(openAIModelTypeString: openAIModelTypeString)
        UserDefaults.standard.set(openAIModelTypeString, forKey: "openAiModelType")
    }
    
    ///Function to set a token
    func setToken(string: String) {
        self.token = OpenAISwift(authToken: string)
        UserDefaults.standard.set(string, forKey: "token")
        setup()
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
        return allModels[index].1
    }
    
    let allModels : [(OpenAIModelType, String)]  = [
        (.gpt3(.davinci), "Most capable GPT-3 model. Can do any task the other models can do, often with higher quality, longer output and better instruction-following. Also supports inserting completions within text."),
        (.gpt3(.ada), "Capable of very simple tasks, usually the fastest model in the GPT-3 series, and lowest cost."),
        (.gpt3(.babbage), "Capable of straightforward tasks, very fast, and lower cost."),
        (.gpt3(.curie), "Very capable, but faster and lower cost than GPT3 davinci"),
        (.codex(.davinci), "Most capable Codex model. Particularly good at translating natural language to code. In addition to completing code, also supports inserting completions within code."),
        (.codex(.cushman), "Almost as capable as davinci Codex, but slightly faster. This speed advantage may make it preferable for real-time applications.")
    ]

}


