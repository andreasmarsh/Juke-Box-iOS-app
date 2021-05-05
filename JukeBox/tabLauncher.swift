//
//  tabLauncher.swift
//  JukeBox
//
//  Created by Andreas Marsh on 4/22/21.
//

import SwiftUI
import Foundation
import WebKit // <-- the cool part

// loads tabs
struct tabLauncher: View {
    @Binding var exit: Bool
    var songName : String
    var artistName : String

    var body: some View {
        // set up url
        let url = "http://www.songsterr.com/a/wa/bestMatchForQueryString?s=" + songName + "&a=" + artistName
        
        // reaplace unallowed characters
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // display url
        webPlayer(link: urlString!) // webPlayer is defnied in musicVideo.swift
    }
}
