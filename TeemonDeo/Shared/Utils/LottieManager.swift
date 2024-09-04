//
//  LottieManager.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/29/24.
//

import Foundation
import Lottie
import UIKit
import SwiftUI

struct LottieView: UIViewRepresentable {
    var filename: String
    //var loopMode: LottieLoopMode = .loop
    var loopMode: LottieLoopMode
    //let animationView = LottieAnimationView(name: filename)
    let animationView = LottieAnimationView()

    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        animationView.animation = LottieAnimation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        //animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func play() {
        animationView.play()
    }
    
    func stop() {
        animationView.stop()
    }
}
