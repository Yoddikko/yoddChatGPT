//
//  OpenAIViewModel.swift
//  YoddChatGpt
//
//  Created by Ale on 17/01/23.
//

import Foundation
import OpenAISwift

final class OpenAIViewModel : ObservableObject {
    
    private var client : OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping((String) -> Void)) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                print(output)
                completion(output)
            case .failure(let error):
                let output = error.localizedDescription
                completion(output)
            }
        })
    }
}
