//
//  CertifyingView.swift
//  TeemonDeo
//
//  Created by TEO on 8/4/24.
//

import SwiftUI

struct CertifyingPicView: View {
    @State private var isFinishedCapture = false
    //@State private var userComment = "world class"
    
    @ObservedObject var cameraViewModel = CameraViewModel()
    @ObservedObject var certifyingPicViewModel = CertifyingViewModel()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .center) {
                Spacer()
                
                Text("버리는 물건을 찍어 인증하세요")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                
                Text("7번째 비움")
                    .modifier(TextModifier())
                
                
                // CameraPreview가 자꾸 왼쪽으로 붙는다 -> HStack, Spacer로 강제 해결
                if let previewImage = cameraViewModel.recentImage {
                    HStack{
                        Spacer()
                        Image(uiImage: previewImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: max(0, geometry.size.width - 16), height: max(0, geometry.size.width - 16))
                            .clipped()
                            .cornerRadius(20)
                            .frame(width: max(0, geometry.size.width - 16), height: max(0, geometry.size.width - 16))
                        Spacer()
                    }
                    .padding(.vertical, 40)

                    afterCaptureView()
                    
                } else {
                    HStack{
                        Spacer()
                        cameraViewModel.cameraPreview
                            .frame(width: max(0, geometry.size.width - 16), height: max(0, geometry.size.width - 16))
                            .cornerRadius(20)
                            .onAppear {
                                cameraViewModel.configure()
                            }
                        Spacer()
                    }
                    .padding(.vertical, 40)
                    
                    beforeCaptureView()
                    
                }
                Spacer()
                
            }
            .background(.black)
        }
    }
}


extension CertifyingPicView {
    
    @ViewBuilder
    private func afterCaptureView() -> some View {
        HStack(alignment: .center) {
            Spacer()
            
            // 플래시 버튼
            Text(" ")
                .frame(width: 42)
            
            Spacer()
            
            // 사진찍기 버튼
            Button(action: {
                certifyingPicViewModel.willUploadImg = cameraViewModel.recentImage
                print(certifyingPicViewModel.willUploadImg)
                certifyingPicViewModel.uploadImg()
                print("완료")
            })
            {
                ZStack{
                    Circle()
                        .fill(Color.Blue)
                        .frame(width: 85, height: 85)
                    Circle()
                        .fill(Color.cameraButtonStroke)
                        .frame(width: 72.86, height: 72.86)
                    Image(systemName: "checkmark")
                        .frame(width: 33, height: 35)
                }
            }
            .foregroundColor(Color.Blue)
            
            Spacer()
            
            Button(action: {
                cameraViewModel.recentImage = nil
                
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 31, height: 36)
            }
            .frame(width: 42)
            .foregroundColor(Color.Blue)
            
            Spacer()
        }
    }
    
    
    
    @ViewBuilder
    private func beforeCaptureView() -> some View {
        HStack(alignment: .center) {
            Spacer()
            
            // 플래시 버튼
            Button(action: {cameraViewModel.switchFlash()}) {
                Image(systemName: cameraViewModel.isFlashOn ?
                      "bolt.fill" : "bolt.slash.fill")
                .resizable()
                .frame(width: 30, height: 36)
                .foregroundColor(Color.Blue)
            }
            .frame(width: 42)
            
            Spacer()
            
            // 사진찍기 버튼
            Button(action: {
                cameraViewModel.capturePhoto()
                // 잠시 보류: isFinishedCapture = true
            })
            {
                ZStack{
                    Circle()
                        .fill(Color.Blue)
                        .frame(width: 85, height: 85)
                    Circle()
                        .stroke(Color.cameraButtonStroke, lineWidth: 3)
                        .fill(Color.Blue)
                        .frame(width: 72.86, height: 72.86)
                }
            }
            .foregroundColor(.blue)
            
            Spacer()
            
            // 전후면 카메라 교체
            Button(action: {cameraViewModel.changeCamera()}) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 42, height: 36)
            }
            .frame(width: 42)
            .foregroundColor(.Blue)
            
            Spacer()
            
        }
    }
}


#Preview {
    CertifyingPicView()
}
