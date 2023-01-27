//
//  OpenAIViewModel.swift
//  YoddChatGpt
//
//  Created by Ale on 17/01/23.
//

import Foundation
import OpenAISwift

/**
 This is the ViewModel that manages the OpenAISwift implementation.

 - Version: 0.1

 */
final class OpenAIViewModel : ObservableObject {
    
    private var client : OpenAISwift?
    
    // TODO: - THIS IS TEMPORARY, REMOVE THIS BEFORE MAKING THE CODE PUBLIC XD OR AT LEAST REMEMBER TO NOT PUT MY API
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping((String, MessageType) -> Void)) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                var messageType : MessageType = .text
                print(output)
                completion(output, messageType)
            case .failure(let error):
                let output = error.localizedDescription
                var messageType : MessageType = .error
                completion(output, messageType)
            }
        })
    }
}
