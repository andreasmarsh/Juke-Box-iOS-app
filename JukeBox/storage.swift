//
//  Storage.swift
//  JukeBox
//
//  Created by Andreas Marsh on 3/22/21.
//

import Foundation

// creates the five arrays that hold five songs each and their relevant info, note that link is the unique YouTube video ID for each video
var rocksongs = [songs(songName: "Everlong", artist: "Foo Fighters", songFile: "everlong.m4a", cover: "everlong", bpm: 144, link: "vLkBybsH73k"),
                 songs(songName: "High And Dry", artist: "Radiohead", songFile: "high.m4a", cover: "bends", bpm: 88, link: "7qFfFVSerQo"),
                 songs(songName: "Losing My Religion", artist: "REM", songFile: "religion.m4a", cover: "time", bpm: 126, link: "xwtdhWltSIg"),
                 songs(songName: "The Suburbs", artist: "Arcade Fire", songFile: "suburbs.m4a", cover: "suburbs", bpm: 118, link: "aqImpqOFWXs"),
                 songs(songName: "When You Were Young", artist: "The Killers", songFile: "young.m4a", cover: "sam", bpm: 130, link: "wRZYu5KFlBI")]

var jazzsongs = [songs(songName: "Fly Me To The Moon", artist: "Frank Sinatra", songFile: "flyMe.m4a", cover: "frank", bpm: 120, link: "Y2rDb4Ur2dw"),
                 songs(songName: "Satin Doll", artist: "Duke Ellington", songFile: "satinDoll.m4a", cover: "duke", bpm: 90, link: "wTFPV1pk654"),
                 songs(songName: "On the Sunny Side of the Street", artist: "Les Paul Mary Ford", songFile: "sunnySide.m4a", cover: "lesPaul", bpm: 83, link: "gtdQOMR31r8"),
                 songs(songName: "Pick Up The Pieces", artist: "Average White Band", songFile: "pieces.m4a", cover: "awb", bpm: 108, link: "X-BJVDuP9dI"),
                 songs(songName: "Birdland", artist: "Weather Report", songFile: "birdland.m4a", cover: "heavy", bpm: 158, link: "pqashW66D7o")]

var altsongs = [songs(songName: "1901", artist: "Phoenix", songFile: "1901.m4a", cover: "wolfgang", bpm: 144, link: "exSt--suaA0"),
                songs(songName: "Apartment", artist: "Young the Giant", songFile: "apartment.m4a", cover: "ytg", bpm: 110, link: "WPUcP3k3CMY"),
                songs(songName: "Wide Eyes", artist: "Local Natives", songFile: "wideEyes.m4a", cover: "localNatives", bpm: 123, link: "hlJCKui43Ow"),
                songs(songName: "Undercover Martyn", artist: "Two Door Cinema Club", songFile: "undercover.m4a", cover: "touristHistory", bpm: 160, link: "LLK4oaXUuLg"),
                songs(songName: "Walcott", artist: "Vampire Weekend", songFile: "walcott.m4a", cover: "vampire", bpm: 160, link: "WXBnzvHQTDI")]

var rapsongs = [songs(songName: "This is America", artist: "Childish Gambino", songFile: "america.m4a", cover: "america", bpm: 120, link: "VYOjWnS4cMY"),
                songs(songName: "Wesleys Theory", artist: "Kendrick Lamar", songFile: "wesleys.m4a", cover: "pimp", bpm: 115, link: "O2qxt9znZdY"),
                songs(songName: "Come Down", artist: "Anderson Paak", songFile: "comeDown.m4a", cover: "malibu", bpm: 98, link: "-OqrcUvrbRY"),
                songs(songName: "Sunday Candy", artist: "Chance The Rapper", songFile: "sunday.m4a", cover: "donnie", bpm: 158, link: "qv6vvDV7MCo"),
                songs(songName: "Wake Up", artist: "Travis Scott", songFile: "wakeUp.m4a", cover: "astro", bpm: 150, link: "yChnkXhauwM")]

var folksongs = [songs(songName: "Slight Figure Of Speech", artist: "The Avett Brothers", songFile: "slightFigure.m4a", cover: "avett", bpm: 166, link: "TE1qFF54MTE"),
                 songs(songName: "Missed Connection", artist: "The Head And The Heart", songFile: "missed.m4a", cover: "living", bpm: 88, link: "Myi1bABePlQ"),
                 songs(songName: "Fast Car", artist: "Tracy Chapman", songFile: "fastCar.m4a", cover: "tracy", bpm: 104, link: "yvGfVdx-gNo"),
                 songs(songName: "Ho Hey", artist: "The Lumineers", songFile: "hoHey.m4a", cover: "lumineers", bpm: 160, link: "Yp8zoatou2E"),
                 songs(songName: "Sour Grapes", artist: "John Prine", songFile: "sourGrapes.m4a", cover: "johnPrine", bpm: 169, link: "IJfmf5upJeY")]

// put all songs arrays into another array, this helps us out later
var allsongs = [rocksongs, jazzsongs, altsongs, rapsongs, folksongs]

// all the stuff that makes up a songs object, even bpm!
struct songs: Identifiable {
    var id = UUID()
    var songName: String
    var artist: String
    var songFile: String
    var cover: String
    var bpm: Double
    var link: String
}
