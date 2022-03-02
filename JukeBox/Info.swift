//
//  Info.swift
//  JukeBox
//
//  Created by Andreas Marsh on 4/23/21.
//

import SwiftUI

struct Info: View {
    // for custom back button
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // clean background used once again
            LinearGradient(gradient: Gradient(colors: [Color ("peach"), Color("redish")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            // lets us resize things to fit various devices
            GeometryReader { geo in
                ZStack {
                    VStack (alignment: .center){
                        
                        // custom resizable spacer
                        Spacer()
                            .frame(height: geo.size.height/10)
                                       
                        // resizable custom font header, so cool!
                        Text("Info / Help")
                            .font(Font.custom("Coming Soon", size: geo.size.height > geo.size.width ? geo.size.width * 0.1: geo.size.height * 0.09))
                            .multilineTextAlignment(.center)
                            .padding(5)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .minimumScaleFactor(0.5)
                        
                        // ScrollView to hold all this dang custom sized and font text
                        ScrollView {
                            Text("This application allows the user to pick a genre and displays 5 songs from the selected genre once 'Explore' is pressed. Once 'Explore' has been pressed, the user can play / pause / skip songs using the four upper row buttons. The user can also click the Book icon to see the Genius lyrics, press the Video icon to see a video of the particlar song, and press the Guitars icon to pull up tabs to the song.\n\nI decided to create this app because of my love for music and the fun I had creating the intial JukeBox application. I love discovering new music and diving into how each song was made. Finding out the significance of the lyrics and the instrumentation used always intrests me so I thought why not put all of that together for everyone to enjoy.\n\nBy storing the data of the artists and song titles I was able to use WebKit to load various webpages once I correctly formatted the URLs. This allowed me to have the Genius pages and Tab pages load without having to hardcode any strings, saving me time and also allowing more songs to be added faster to the app. I still had to hardcode the data of each song including the Youtube ID for each video but that wasn't too bad.\n\nI hope you enjoy the app and find yourself diving deeper into music as a whole. ✌️\n\n-Andreas")
                                .multilineTextAlignment(.center)
                                .font(Font.custom("Coming Soon", size: geo.size.height > geo.size.width ? geo.size.width * 0.05: geo.size.height * 0.09))
                                .padding(10)
                            
                        }
                        Spacer()
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                // so that things are centered in the geo reader
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        // custom back button
        .navigationBarItems(leading:
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "chevron.left.circle.fill")
                                        .padding()
                                        .font(.title)   
                                        .foregroundColor(Color ("blueish"))
                                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 3.3, x: 0, y: 0)
                                })
        )
    }
}

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Info()
    }
}
