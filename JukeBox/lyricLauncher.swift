//
//  lyricLauncher.swift
//  JukeBox
//
//  Created by Andreas Marsh on 4/22/21.
//

import SwiftUI
import Foundation
import WebKit // <-- the cool part

// loads Genius lyrics
struct lyricLauncher: View {
    @Binding var exit: Bool
    var songName : String
    var artistName : String

    var body: some View {
        // set up url
        let url = "https://genius.com/" + artistName + "-" + songName + "-lyrics"
        
        // reformat spaces to be -'s
        let urlString:String = url.replacingOccurrences(of: " ", with: "-")
        
        // display url
        webPlayer(link: urlString)
    }
}
