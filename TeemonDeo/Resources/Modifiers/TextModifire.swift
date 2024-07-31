//
//  TextModifire.swift
//  TeemonDeo
//
//  Created by TEO on 7/31/24.
//

import SwiftUI



/// 어떤 View에 대해 font와 foregroundColor를 적용하는 Modifier
struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 30)
            .font(.body)
            .foregroundStyle(Color.certifyLabelText)
            .background(Color.certifyLabel)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        // Clipp shape 방법 조금 안좋은 것 같다
    }
}
