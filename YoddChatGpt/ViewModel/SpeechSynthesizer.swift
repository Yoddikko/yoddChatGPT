/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


//
//  SpeechSynthesizer.swift
//  YoddChatGpt
//
//  Created by Ale on 26/01/23.
//

import Foundation
import AVFoundation
import NaturalLanguage
import SwiftUI

/**
 This is the ViewModel that manages the AVFoundation synthesizer and the NaturalLanguage frameworks.

 - Version: 0.1

 */
class SpeechSynthesizer: ObservableObject {
    static let shared = SpeechSynthesizer()
    @Published var speechSynthesizer = AVSpeechSynthesizer()
/// This function read the text using the right synthesis voice language (if available, otherwise it will use
/// en-US language)
    func readString (text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: recognizeLanguage(text: text))
        speechSynthesizer.speak(utterance)
        
    }
    
    ///This function detects the language of a text (if available, otherwise it will return en-US language)
    func recognizeLanguage (text: String) -> String {
        var dominantLanguage = "en"
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(text)
        if let tmpDominantLanguage = languageRecognizer.dominantLanguage {
            dominantLanguage = tmpDominantLanguage.rawValue
            return dominantLanguage
        }
        return dominantLanguage
    }
    
    
}
