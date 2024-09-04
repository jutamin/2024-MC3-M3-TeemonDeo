//
//  TierInfoView.swift
//  TeemonDeo
//
//  Created by 원주연 on 8/6/24.
//

import SwiftUI

struct TierInfoView: View {
    var body: some View {
        ScrollView{
            Image("TierInfoViewImage")
                .resizable()
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    TierInfoView()
}
