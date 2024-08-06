//
//  CertifyingView.swift
//  TeemonDeo
//
//  Created by TEO on 8/4/24.
//

import SwiftUI

struct CertifyingView: View {
    @Binding var path: NavigationPath

    var certiChalData: CertifyingData
    
    @ObservedObject var cameraViewModel = CameraViewModel()
    @ObservedObject var certifyingiewModel = CertifyingViewModel()
    
    @State private var isFinishedCapture = false
    @State private var imageMemo: String = ""
    
    @State private var allFinished = false

    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .center) {
                Spacer()
                
                Text("7번째 비움")
                    .modifier(TextModifier())
                    .padding(.bottom)
                
                Text("버리는 물건을 찍어 인증하세요")
                    .font(.SuitTitle2)
                    .foregroundColor(.white)

                
                // CameraPreview가 자꾸 왼쪽으로 붙는다 -> HStack, Spacer로 강제 해결
                if let previewImage = cameraViewModel.recentImage {
                    HStack{
                        Spacer()
                        ZStack(alignment: .bottom){
                            Image(uiImage: previewImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: max(0, geometry.size.width - 16), height: max(0, geometry.size.width - 16))
                                .clipped()
                                .cornerRadius(20)
                                .frame(width: max(0, geometry.size.width - 16), height: max(0, geometry.size.width - 16))
                            TextField("간단한 메모를 남겨보세요", text: $imageMemo)
                                .font(.SuitBody1)
                                .frame(width: 196, height: 46)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.imageTextBox)
                                )
                                .padding(.bottom)
                        }
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
            .navigationBarBackButtonHidden()
        }
    }
}


extension CertifyingView {
    
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
                print("완료")
                Task {
                    try await certifyingiewModel.uploadImg(challengeId: certiChalData.challenge.id, recordMemo: imageMemo, willUploadImg: cameraViewModel.recentImage)
                }
                //allFinished = true
                //path.append("CertifyingFinishedView")
                path.append(CertifyingFinishedData(challenge: certiChalData.challenge))

            })
            {
                ZStack{
                    Circle()
                        .fill(Color.LightBlue)
                        .stroke(Color.Blue, lineWidth: 3.64)
                        .frame(width: 85, height: 85)
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
                .foregroundColor(Color.gray600)
            }
            .frame(width: 42)
            
            Spacer()
            
            // 사진찍기 버튼
            Button(action: {
                print("before cameraViewModel.capturePhoto()")
                cameraViewModel.capturePhoto()
                // 잠시 보류: isFinishedCapture = true
            })
            {
                ZStack{
                    Circle()
                        .fill(Color.Blue)
                        .frame(width: 85, height: 85)
                    Circle()
                        .stroke(Color.cameraButtonStroke, lineWidth: 5)
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
            .foregroundColor(.gray600)
            
            Spacer()
        }
    }
}


