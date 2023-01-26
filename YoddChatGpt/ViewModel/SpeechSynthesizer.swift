//
//  SpeechSynthesizer.swift
//  YoddChatGpt
//
//  Created by Ale on 26/01/23.
//

import Foundation
import AVFoundation
import NaturalLanguage

class SpeechSynthesizer {
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func readString (text : String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: recognizeLanguage(text: text))
        speechSynthesizer.speak(utterance)
    }
    
    func recognizeLanguage (text: String) -> String {
        var dominantLanguage = "en-US"
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(text)
        if let tmpDominantLanguage = languageRecognizer.dominantLanguage {
            dominantLanguage = tmpDominantLanguage.rawValue
           return dominantLanguage
        }
        return dominantLanguage
    }

}
