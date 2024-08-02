//
//  PieChartView.swift
//  TeemonDeo
//
//  Created by 원주연 on 8/2/24.
//

import SwiftUI
import Charts


struct iPhoneOperationSystem {
    let version: String
    let count: Int
    
    static func dummyData() -> [iPhoneOperationSystem] {
        return [
            iPhoneOperationSystem(version: "16.0", count: 81),
            iPhoneOperationSystem(version: "15.0", count: 13),
            iPhoneOperationSystem(version: "14.0", count: 6)
        ]
    }
}

struct PieChartView: View {
    
    var data: [iPhoneOperationSystem]
    
    var body: some View {
        Chart(data, id: \.version) { element in
            SectorMark(angle: .value("Usage", element.count))
                .foregroundStyle(by: .value("Version", element.version))
        }
        .padding()
    }
}
#Preview {
    PieChartView(data: iPhoneOperationSystem.dummyData())
}
