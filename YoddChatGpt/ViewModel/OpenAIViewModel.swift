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

 - Version: 0.2

 */
final class OpenAIViewModel : ObservableObject {
    
    private var client : OpenAISwift?
    
    static var shared = OpenAIViewModel()
    

    @Published var token : OpenAISwift?
    @Published var tokenUserDefaults : String = UserDefaults.standard.string(forKey: "token") ?? ""

    // TODO: - THIS IS TEMPORARY, REMOVE THIS BEFORE MAKING THE CODE PUBLIC XD OR AT LEAST REMEMBER TO NOT PUT MY API
    func setup() {
        token = OpenAISwift(authToken: UserDefaults.standard.string(forKey: "token") ?? "")
//        print(UserDefaults.standard.string(forKey: "token") ?? "")
    }
    //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
    
    func send(text: String, completion: @escaping((String, MessageType) -> Void)) {
        token?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
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
    
    ///Function to set a token
    func setToken(string: String) {
        self.token = OpenAISwift(authToken: string)
        UserDefaults.standard.set(string, forKey: "token")
        setup()
    }
    
}
