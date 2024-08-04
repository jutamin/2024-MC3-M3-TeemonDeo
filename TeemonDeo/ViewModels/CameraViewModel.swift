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
        model.session.startRunning()
        // 0729 추가
    }
    
    func switchFlash() {
        isFlashOn.toggle()
    }
    
    func switchSilent() {
        isSilentModeOn.toggle()
    }

    
    func capturePhoto() {
        model.capturePhoto()
        
        print("[CameraViewModel]: Photo captured!")
    }
    
    func changeCamera() {
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
