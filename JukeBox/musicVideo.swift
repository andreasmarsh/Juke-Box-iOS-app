//
//  musicVideo.swift
//  JukeBox
//
//  Created by Andreas Marsh on 4/22/21.
//

import SwiftUI
import Foundation
import WebKit // <-- the cool part

// loads music videos
struct musicVideo: View {
    @Binding var exit: Bool
    var video : Int
    var genre : Int
    
    var body: some View {
        // loads appropriate video thanks to double array allsongs and value .link
        webPlayer(link: "https://youtu.be/" + allsongs[genre][video].link)
    }
}

// what actually happens when webPlayer is called, loads card over current view
struct webPlayer : UIViewRepresentable {
    var link : String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: link) else {
            return WKWebView()
        }
        let controller = WKWebView()
        let request = URLRequest(url: url)
        controller.load(request)
        return controller
    }
    func updateUIView(_ uiView: webPlayer.UIViewType, context: UIViewRepresentableContext<webPlayer>) {
    }
}
