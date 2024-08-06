//
//  ChallengeRecordView.swift
//  TeemonDeo
//
//  Created by Geunhye on 8/4/24.
//

import SwiftUI

struct ChallengeRecordComponent: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("mainviewcharactor")
                .resizable()
                .scaledToFit()
                .padding(10)
                .background(.gray)
                .cornerRadius(6)
                .overlay(alignment: .topLeading) {
                    Circle()
                        .frame(width: 33, height: 33)
                        .padding(10)
                        .overlay(alignment: .center) {
                            Text("01")
                                .foregroundColor(.white)
                        }
                }
            Text("한동안 사용하지 않은 가방을 기부하세요.")
        }
    }
}

#Preview {
    ChallengeRecordComponent()
}
