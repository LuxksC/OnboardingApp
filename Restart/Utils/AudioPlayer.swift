//
//  AudioPlayer.swift
//  Restart
//
//  Created by Lucas de Castro Souza on 03/07/23.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

enum AudioType: String {
    case mp3 = "mp3"
    case m4a = "m4a"
}

func playSound(sound: String, type: AudioType) {
    if let path = Bundle.main.path(forResource: sound, ofType: type.rawValue) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not play sound file!")
        }
    }
}
