//
//  PieChartView.swift
//  TeemonDeo
//
//  Created by 원주연 on 8/2/24.
//

import SwiftUI
import Charts


struct challengeProgressChart: Identifiable {
    let id: String
    let challengeName: String
    let progress: Int
}

struct PieChartView: View {
    
    var data: [challengeProgressChart]
    

    var body: some View {
        Chart(data) { element in
            SectorMark(angle: .value("Progress", element.progress), angularInset: 1.5)
                .foregroundStyle(element.challengeName == "default" ? Color.gray200 : Color.Blue)
        }
        .chartLegend(.hidden)
        .frame(maxWidth: 26, maxHeight: 26)
        .padding()
    }
}
//#Preview {
//    PieChartView(data: iPhoneOperationSystem.dummyData())
//}
