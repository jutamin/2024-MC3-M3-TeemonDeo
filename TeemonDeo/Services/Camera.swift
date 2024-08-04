//
//  Camera.swift
//  TeemonDeo
//
//  Created by TEO on 8/4/24.
//


import Foundation
import AVFoundation
import UIKit

// ✅ 추가2 NSObject - AVCapturePhotoCaptureDelegate를 이용하기 위해서
class Camera:  NSObject, ObservableObject {
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    
    
    var isSilentModeOn = true
    // ✅ 추가2
    var photoData = Data(count: 0)
    // ✅ 변수 추가2
    @Published var recentImage: UIImage?
    
    // 카메라 셋업 과정을 담당하는 함수
    func setUpCamera() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for: .video, position: .back) {
            do { // 카메라가 사용 가능하면 세션에 input과 output을 연결
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    //output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .speed
                }
                
                
                // session.startRunning() // 세션 시작
            } catch {
                print(error) // 에러 프린트
            }
        }
    }
    
    func requestAndCheckPermissions() {
        // 카메라 권한 상태 확인
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // 권한 요청
            AVCaptureDevice.requestAccess(for: .video) { [weak self] authStatus in
                if authStatus {
                    DispatchQueue.main.async {
                        self?.setUpCamera()
                    }
                }
            }
        case .restricted:
            break
        case .authorized:
            // 이미 권한 받은 경우 셋업
            setUpCamera()
        default:
            // 거절했을 경우
            print("Permession declined")
        }
    }
    
    // ✅ 추가2 - 실질적으로 사진을 촬영하는 함수
    func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        
        self.output.capturePhoto(with: photoSettings, delegate: self)
        print("[Camera]: Photo's taken")
    }
    
//    // ✅ 추가2
//    func savePhoto(_ imageData: Data) {
//        guard let image = UIImage(data: imageData) else { return }
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//
//        // 사진 저장하기
//        print("[Camera]: Photo's saved")
//    }
    
    // ✅ 추가2
    func savePhoto(_ imageData: UIImage) {
        //guard let image = UIImage(data: imageData) else { return }
        UIImageWriteToSavedPhotosAlbum(imageData, nil, nil, nil)
        
        // 사진 저장하기
        print("[Camera]: Photo's saved")
    }
    
}


// ✅ extension 추가2
extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            print("[Camera]: Silent sound activated")
            AudioServicesDisposeSystemSoundID(1108)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            AudioServicesDisposeSystemSoundID(1108)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        self.recentImage = squareImage(from: UIImage(data: imageData)!)
        self.savePhoto(self.recentImage!)

        print("[CameraModel]: Capture routine's done")
    }


    func squareImage(from image: UIImage) -> UIImage? {
        let originalWih = image.size.width

        let originalWidth = image.cgImage?.width ?? 0
        let originalHeight = image.cgImage?.height ?? 0
        let squareLength = min(originalWidth, originalHeight)

        let xOffset = Double(originalWidth - squareLength) / 2.0
        let yOffset = Double(originalHeight - squareLength) / 2.0

        let cropRect = CGRect(x: xOffset, y: yOffset, width: CGFloat(squareLength), height: CGFloat(squareLength))

        if let cgImage = image.cgImage?.cropping(to: cropRect) {
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
        }
        return nil
    }

}
