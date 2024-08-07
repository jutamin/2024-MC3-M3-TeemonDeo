//
//  ChallengeRecordView.swift
//  TeemonDeo
//
//  Created by Geunhye on 8/4/24.
//

import SwiftUI
import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift

struct ChallengeRecordView: View {
    @StateObject var challengeRecordViewModel = ChallengeRecordViewModel()

    var challengeData: Challenge
//    var records: [ChallengeRecord] // 실제 ChallengeRecord 객체 리스트

    let columns = [
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
        GridItem(.flexible(minimum: 0, maximum: .infinity))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(challengeRecordViewModel.tempRecords) { record in
                        challengeRecordComponent(record: record) // 실제 데이터 전달
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear{
            Task{
                await challengeRecordViewModel.loadRecords(challengeId: challengeData.id)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("챌린지 기록")
                    .font(.SuitTitle2)
            }
            ToolbarItem(placement: .topBarTrailing) {
                RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2.0)
                    .frame(width: 58, height: 28)
                    .foregroundColor(.white)
                    .overlay {
                        Text("\(challengeRecordViewModel.recordCount) / 21")
                    }
            }
            
        }
    }
}




extension ChallengeRecordView {

    @ViewBuilder
    private func challengeRecordComponent(record: TempRecord) -> some View {
        VStack {
            AsyncImage(url: URL(string: record.imageData)) { phase in
                switch phase {
                case .empty:
                    ProgressView() // 로딩 중일 때 표시
                case .success(let image):
                    VStack{
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .padding(10)
//                            .overlay(alignment: .topLeading) {
//                                Circle()
//                                    .frame(width: 33, height: 33)
//                                    .padding(10)
//                                    .overlay(alignment: .center) {
//                                        Text("\(countNum)")
//                                            .foregroundColor(.white)
//                                    }
//                            }
                            .padding(.bottom)
                        
                        Text("\(record.recordChallengeText )")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .frame(width: 154 ,height: 17)
                    }
                case .failure(_):
                    Image("mainviewcharactor") // 로딩 실패 시 대체 이미지
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                        .background(.gray)
                        .cornerRadius(6)
//                        .overlay(alignment: .topLeading) {
//                            Circle()
//                                .frame(width: 33, height: 33)
//                                .padding(10)
//                                .overlay(alignment: .center) {
//                                    Text("01")
//                                        .foregroundColor(.white)
//                                }
//                        }
                @unknown default:
                    EmptyView()
                }
            }
        }

    }
}
