//
//  ChallengeRecordDetailView.swift
//  TeemonDeo
//
//  Created by Geunhye on 8/5/24.
//

import SwiftUI

struct ChallengeRecordDetailView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "chevron.left")
                Spacer()
                Text("챌린지 기록")
                Spacer()
            }
            .padding()
            VStack(alignment: . leading) {
                Image("mainviewcharactor")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .background(.gray)
                    .cornerRadius(6)
                    .frame(width: 353, height: 353)
                VStack(alignment: .leading) {
                    HStack{
                        Image("challengeIcon")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(6)
                            .frame(width: 16, height: 16)
                        Text("책상부터 비워보자")
                    }
                    Text("한동안 사용하지 않은 가방을 기부하세요.")
                }
                .padding()
            }
        }
    }
}

#Preview {
    ChallengeRecordDetailView()
}
