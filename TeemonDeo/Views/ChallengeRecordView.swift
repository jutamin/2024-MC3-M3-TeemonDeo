//
//  ChallengeRecordView.swift
//  TeemonDeo
//
//  Created by Geunhye on 8/4/24.
//

import SwiftUI

struct ChallengeRecordView: View {
    
    let data = Array(1...10).map { "목록 \($0)"}

    let columns = [
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
        GridItem(.flexible(minimum: 0, maximum: .infinity))
    ]
    
    var body: some View {
        VStack(spacing:0){
            HStack{
                Image(systemName: "chevron.left")
                Spacer()
                Text("챌린지 기록")
                Spacer()
                RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2.0)
                    .frame(width: 58, height: 28)
                    .foregroundColor(.white)
                    .overlay {
                        Text("\(columns.count)"+"/21")
                    }
            }
            .padding()
            ScrollView(.vertical){
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { i in
                        ChallengeRecordComponent()
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ChallengeRecordView()
}
