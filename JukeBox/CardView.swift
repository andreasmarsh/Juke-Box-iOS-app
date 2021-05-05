//
//  CardView.swift
//  JukeBox
//
//  Created by Andreas Marsh on 3/22/21.
//

import SwiftUI
import AVFoundation

// repeats the pulsing animation that plays while a song is playing
extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}

// the meat of the entire app, soak it up!
struct CardView: View {
    // all the vars, we have global, state, and even an observableObj
    @EnvironmentObject var holder: GlobalIndex
    @EnvironmentObject var genreNum: GlobalGenre
    @State private var firstPlay = true
    @State private var lyrics = false
    @State private var video = false
    @State private var tabs = false
    @Environment(\.presentationMode) var presentationMode // for custom back button
    @ObservedObject var twist = AudioPlayer() // used to play songs and know when songs are over
    var song: songs
    
    var body: some View {
        
        let freq = 60 / song.bpm // complex maths to make the pulse animation perfectly match the song
        
        ZStack {
            // nice background, now slightly different than before
            LinearGradient(gradient: Gradient(colors: [Color ("peach"), Color("redish")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            // the pulsing effect that matches the song
            Circle()
                .foregroundColor(twist.isPlaying ? .blue : .green)
                .opacity(0.5)
                .scaleEffect(twist.isPlaying ? 1.8 : 1.4) // makes the circle grow and shrink
                .opacity(twist.isPlaying ? 1 : 0) // the most important part, appear and disappear
                .animation(Animation.easeInOut(duration: freq).repeat(while: twist.isPlaying)) // repeat animation while playing and until paused or song is over
            
            GeometryReader { geo in // so things scale based on device
                ZStack {
                    
                    VStack(alignment: .center) {
                        
                        // custom sizing spacer
                        Spacer()
                            .frame(height: geo.size.height/15)
                        
                        // custom font and sizing for song name
                        Text(song.songName)
                            .font(Font.custom("Coming Soon", size: geo.size.height > geo.size.width ? geo.size.width * 0.1: geo.size.height * 0.09))
                            .multilineTextAlignment(.center)
                            .padding(5)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .minimumScaleFactor(0.5)
                        
                        // custom font and sizing for artist name
                        Text("By: " + song.artist)
                            .font(Font.custom("Coming Soon", size: geo.size.height > geo.size.width ? geo.size.width * 0.06: geo.size.height * 0.09))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                            .minimumScaleFactor(0.5)
                        
                        
                        Spacer()
                            .frame(height: 30)
                        
                        // image that shrinks and darkens when paused
                        Image(song.cover)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .brightness(twist.isPlaying ? 0 : -0.3)
                            .padding(twist.isPlaying ? 15 : 50)
                            .animation(.spring(response: 0.6, dampingFraction: 0.4, blendDuration: 0.7))
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: 4, y: 8)
                        
                        Spacer()
                            .frame(height: 40)
                        
                        // HStack back, play, pause, skip
                        HStack(spacing: 60.0) {
                            
                            // back button
                            Button(action: {
                                if (holder.index > 0) {
                                    holder.index -= 1
                                } else {
                                    holder.index = 4
                                }
                                firstPlay = true
                                self.twist.paws()
                                twist.isPlaying = false
                            }) {
                                Image(systemName: "arrow.backward")
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            }
                            
                            // play button
                            Button(action: {
                                if (firstPlay) {
                                    self.twist.playsound(thesong: song.songFile)
                                    firstPlay = false
                                } else {
                                    self.twist.player()
                                }
                                twist.isPlaying = true
                            }) {
                                if (twist.isPlaying == false) {
                                    Image(systemName: "play")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                } else {
                                    Image(systemName: "play.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                }
                            }
                            
                            // pause button
                            Button(action: {
                                self.twist.paws()
                                twist.isPlaying = false
                            }) {
                                if (twist.isPlaying == false) {
                                    Image(systemName: "pause.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                } else {
                                    Image(systemName: "pause")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                }
                            }
                            
                            // skip button
                            Button(action: {
                                if (holder.index < 4) {
                                    holder.index += 1
                                } else {
                                    holder.index = 0
                                }
                                firstPlay = true;
                                self.twist.paws()
                                twist.isPlaying = false
                            }) {
                                Image(systemName: "arrow.forward")
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            }
                        }
                        
                        // space between button rows
                        Spacer()
                            .frame(height: 22)
                        
                        // HStack lyrics, video, tabs
                        HStack(spacing: 54.0) {
                            
                            // lyrics
                            Button(action: {
                                lyrics = !lyrics
                            }) {
                                if (lyrics == false) {
                                    Image(systemName: "book")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                } else {
                                    Image(systemName: "book.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                }
                            }
                            .sheet(isPresented: $lyrics) {
                                lyricLauncher(exit: self.$lyrics, songName: song.songName , artistName: song.artist)
                            }
                            
                            // video
                            Button(action: {
                                video = !video
                                self.twist.paws()
                                twist.isPlaying = false
                            }) {
                                if (video == false) {
                                    Image(systemName: "video")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                } else {
                                    Image(systemName: "video.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                }
                            }
                            .sheet(isPresented: $video) {
                                musicVideo(exit: self.$video, video: Int(holder.index), genre: Int(genreNum.genre))
                            }
                            
                            // tabs
                            Button(action: {
                                tabs = !tabs
                                self.twist.paws()
                                twist.isPlaying = false
                            }) {
                                if (tabs == false) {
                                    Image(systemName: "guitars")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                } else {
                                    Image(systemName: "guitars.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                }
                            }
                            .sheet(isPresented: $tabs) {
                                tabLauncher(exit: self.$tabs, songName: song.songName , artistName: song.artist)
                            }
                        }
                        
                        Spacer()
                            .frame(height: 40)
                    }
                    .cornerRadius(10)
                    .padding([.top, .horizontal])
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center) // centers things in geo reader
            }
        }
        .edgesIgnoringSafeArea(.top) // because of custom nav button
        .navigationBarBackButtonHidden(true)
        // the custom back button, also pauses songs for ya
        .navigationBarItems(leading:
                                Button(action: {
                                    self.twist.paws()
                                    twist.isPlaying = false
                                    self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "chevron.left.circle.fill")
                                        .padding()
                                        .font(.largeTitle)
                                        .foregroundColor(Color ("blueish"))
                                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 3.3, x: 0, y: 0)
                                })
        )
    }
}
