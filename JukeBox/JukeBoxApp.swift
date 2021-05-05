//
//  JukeBoxApp.swift
//  JukeBox
//
//  Created by Andreas Marsh on 3/22/21.
//

import SwiftUI

@main
struct JukeBoxApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GlobalIndex())
                .environmentObject(GlobalGenre())
        }
    }
}
