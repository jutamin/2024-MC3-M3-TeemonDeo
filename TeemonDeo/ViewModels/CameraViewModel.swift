//
//  CameraViewModel.swift
//  TeemonDeo
//
//  Created by TEO on 8/4/24.
//

import Combine
import SwiftUI
import AVFoundation

class CameraViewModel: ObservableObject {
    
    private let model: Camera
    private let session: AVCaptureSession
    let cameraPreview: AnyView

    // ✅ 변수 추가2
    private var subscriptions = Set<AnyCancellable>()
    // ✅ 변수 추가2
    @Published var recentImage: UIImage?
    
    @Published var isFlashOn = false
    @Published var isSilentModeOn = false

    func configure() {
        model.requestAndCheckPermissions()
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.model.session.startRunning()
//        }
    }
    
    func switchFlash() {
        isFlashOn.toggle()
        // ✅ 추가3
        model.flashMode = isFlashOn == true ? .on : .off
    }
    
    func switchSilent() {
        isSilentModeOn.toggle()
    }

    
    func capturePhoto() {
        print("in viewmodel before model.capturePhoto()")
        model.capturePhoto()
        
        print("[CameraViewModel]: Photo captured!")
    }
    
    func changeCamera() {
        // ✅ 추가4
        model.changeCamera()
        print("[CameraViewModel]: Camera changed!")
    }
    
    init() {
        model = Camera()
        session = model.session
        cameraPreview = AnyView(CameraPreviewView(session: session))
        
        // ✅ sink 추가2
        model.$recentImage.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.recentImage = pic
        }
        .store(in: &self.subscriptions)
    }
}
