//
//  AudioPlayer.swift
//  JukeBox
//
//  Created by Andreas Marsh on 4/25/21.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

// how we get audio to play and change CardView when the song ends
class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    // isPlaying is very important as it is what's used in CardView
    var isPlaying = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    // play sing based on file name, note the folders to the left that hold m4a files
    func playsound (thesong: String){
        let thepath = Bundle.main.path(forAuxiliaryExecutable: thesong)!
        let url = URL(fileURLWithPath: thepath)
        do {
            twist = try AVAudioPlayer(contentsOf: url)
            twist?.delegate = self // very important line, lets AudioPlayer know when song is over
            twist?.play()
            isPlaying = true
        } catch {
            // couldn't load file :(
        }
    }
    
    // just pause
    func paws(){
        twist?.pause()
        isPlaying = false
    }
    
    // just play
    func player(){
        twist?.play()
        isPlaying = true
    }
    
    // sets isPlaying to false when song ends, very nice!
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}
