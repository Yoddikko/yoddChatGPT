//
//  SpeechSynthesizer.swift
//  YoddChatGpt
//
//  Created by Ale on 26/01/23.
//

import Foundation
import AVFoundation
import NaturalLanguage

/**
 This is the ViewModel that manages the AVFoundation synthesizer and the NaturalLanguage frameworks.

 - Version: 0.1

 */
class SpeechSynthesizer {
    let speechSynthesizer = AVSpeechSynthesizer()
    
    ///This function read the text using the right synthesis voice language (if available, otherwise it will use en-US language)
    func readString (text : String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: recognizeLanguage(text: text))
        speechSynthesizer.speak(utterance)
    }
    
    ///This function detects the language of a text (if available, otherwise it will return en-US language)
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
