//
//  AudioPlayer.swift
//  YoddChatGpt
//
//  Created by Ale on 26/01/23.

import AVFoundation


class AudioPlayer {
    var player: AVAudioPlayer?
    
    
    func playMessageSound(sender : Sender) {
        var path = Bundle.main.path(forResource: "SentMessage", ofType:"mp3")!
        
        if sender == .bot {
            path = Bundle.main.path(forResource: "RecievedMessage", ofType:"mp3")!
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            // couldn't load file :(
        }}
}
