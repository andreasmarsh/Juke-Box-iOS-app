//
//  ContentView.swift
//  JukeBox
//
//  Created by Andreas Marsh on 3/22/21.
//
//  This app allows the user to select one out of 5 genres and then gives the user 5 songs
//  of that genre. The user can play a song sample, pause said sample, skip to the next sample,
//  check out the Genius lyrics of the particular song, see a music video of the particular
//  song, or look at tabs for the particular song.
//

import SwiftUI
import AVFoundation
var twist: AVAudioPlayer?

// used to know index of which song is to be displayed
class GlobalIndex: ObservableObject {
    @Published var index = 0
}

// used to know which genre is selected
class GlobalGenre: ObservableObject {
    @Published var genre = 0
}

// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct ContentView: View {
    // intialization of Global vars
    @EnvironmentObject var holder: GlobalIndex
    @EnvironmentObject var genreNum: GlobalGenre
    
    @State private var genre = "" // display name
    @State private var genrePicked = 0 // the value of where the selected fish appears in list
    
    // used for displaying picker
    @State private var presentPicker = false
    @State private var tag: Int = 0
    @State private var menuUp: Bool = false
    @State private var screenWidth = UIScreen.main.bounds.size.width // width
    @State private var screenHeight = UIScreen.main.bounds.size.height // height
    @State private var orientation = UIDeviceOrientation.unknown // for orientation
    
    // define which genre options will be avaliable
    var genres = ["rock", "jazz", "indie", "rap", "americana/folk"]
    @State var genrecount = 0;
    
    var body: some View {
        NavigationView {
            // custom colors used to make a clean background that fits a nice pallete
            LinearGradient(gradient: Gradient(colors: [Color ("peach"), Color("redish")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    ZStack (alignment: .center) {
                        // GeometryReader used so that layout resizes based on device size
                        GeometryReader { geo in
                            ZStack() {
                                VStack(alignment: .center) {
                                    
                                    // Spacer for resizable positioning
                                    Spacer()
                                        .frame(height: geo.size.height/6)
                                    
                                    // Heading is also resizable and features a custom font, wow!
                                    HStack (alignment: .center){
                                        Text("Pick a genre to Explore")
                                            .font(Font.custom("Coming Soon", size: geo.size.height > geo.size.width ? geo.size.width * 0.09: geo.size.height * 0.09))
                                            .multilineTextAlignment(.center)
                                            .padding(5)
                                    }
                                    
                                    // extra spacer for adjustable sizing
                                    Spacer()
                                        .frame(height: geo.size.height/16)
                                    
                                    // CustomPicker
                                    CustomPickerTextView(presentPicker: $presentPicker,
                                                         fieldString: $genre,
                                                         width: screenWidth,
                                                         placeholder: Text("Select a Genre")
                                                            .font(Font.custom("Coming Soon", size: screenHeight > screenWidth ? screenWidth * 0.05: screenHeight * 0.07)),
                                                         tag: $tag,
                                                         selectedTag: tag)
                                        .frame(width: screenWidth/1.5)
                                        .padding()
                                    
                                    // extra spacer for adjustable sizing
                                    Spacer()
                                        .frame(height: geo.size.height/10)
                                    
                                    VStack(alignment: .center) {
                                        
                                        // Takes user to relevant genre CardView
                                        NavigationLink(destination:  CardView(song: allsongs[genrePicked][holder.index])) {
                                            ButtonView(image: "music.quarternote.3", title: "Explore")
                                        } .simultaneousGesture(TapGesture().onEnded{
                                            // if genre is different display the first song otherwise jump back to same song as last displayed
                                            if (genreNum.genre != genrePicked) {
                                                holder.index = 0
                                            }
                                            genreNum.genre = genrePicked
                                        })
                                        
                                        // the navLinks were weird so this had to be a set Spacer()
                                        Spacer()
                                            .frame(height: 20)
                                        
                                        // simply open Info View
                                        NavigationLink(destination:  Info()) {
                                            ButtonView(image: "questionmark.circle", title: "Info / Help")
                                        }
                                    }
                                    
                                    // bottom resizable spacer
                                    Spacer()
                                        .frame(height: geo.size.height/3)
                                }
                            } .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            // centers the things in geo reader ^
                            
                            // for handling which picker to display based on common or scientific selection
                            if presentPicker {
                                if tag == 0 {
                                    CustomPickerView(items: genres.sorted(),
                                                     pickerField: $genre,
                                                     presentPicker: $presentPicker,
                                                     val: $genrePicked,
                                                     fieldList: genres,
                                                     width: screenWidth,
                                                     height: screenHeight)
                                        .zIndex(2.0)
                                }
                            }
                            
                        }
                    }.onRotate { newOrientation in
                        orientation = newOrientation
                        screenWidth = UIScreen.main.bounds.size.width
                        screenHeight = UIScreen.main.bounds.size.height
                    })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        // makes iPad display same as iPhones, no need for weird side bar
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalIndex()).environmentObject(GlobalGenre())
    }
}

// Custom features for nav links
struct ButtonView: View {
    var image: String
    var title: String
    
    var body: some View {
        
        HStack {
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundColor(.white)
                .shadow(color: Color("blueish"), radius: 5)
            Text(title)
                .foregroundColor(.white)
                // custom font, wow!
                .font(Font.custom("Coming Soon", size: 30))
                .shadow(color: Color("blueish"), radius: 5)
        }
        .foregroundColor(.white)
        .padding(12)
        .background(LinearGradient(gradient: Gradient(colors: [Color ("blueish"), Color("redish")]), startPoint: .leading, endPoint: .bottomTrailing))
        .cornerRadius(40)
        .padding(.horizontal, 40)
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: 2, y: 4)
    }
}
