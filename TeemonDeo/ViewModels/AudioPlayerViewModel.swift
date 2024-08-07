//
//  AudioPlayerViewModel.swift
//  TeemonDeo
//
//  Created by Geunhye on 8/1/24.
//

import AVFoundation

class AudioPlayerViewModel: ObservableObject {
  var audioPlayer: AVAudioPlayer?

  @Published var isPlaying = false

  init() {
    if let sound = Bundle.main.path(forResource: "Avocado", ofType: "mp3") {
      do {
        self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
      } catch {
        print("AVAudioPlayer could not be instantiated.")
      }
    } else {
      print("Audio file could not be found.")
    }
  }

  func playOrPause() {
    guard let player = audioPlayer else { return }

//    if player.isPlaying {
//      player.pause()
//      isPlaying = false
//    } else {
//      player.play()
//      isPlaying = true
//    }
      player.play()
      isPlaying = true
      player.numberOfLoops = -1
  }
    
    func stop() {
        guard let player = audioPlayer else { return }
        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }


}

